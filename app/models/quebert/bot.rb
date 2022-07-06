module Quebert
  class Bot < ApplicationRecord
    has_many :posts
    has_one :cronfig

    @@responses = Quebert::Response

    def handle_slash_command(params)
      command = params[:command]
      payload = params[:payload]

      case command
      when 'status'
        status
      when 'que'
        add_post_to_queue(payload)
      when 'clear'
        remove_from_queue(payload)
      else
        { error: "#{command} : command not recognized." }
      end
    end

    def que_routine
      update(last_qrtine: Time.now)
      cur_que_length = posts.queued.length
      # no posts in queue return
      return { message: @@response.que_routine(false, cur_que_length) } unless !!cur_que_length

      # posts in que
      que_posts = posts.queued.uniq { |p| p.target }
      que_posts.each { |p| p.update(queued: false) }
      posts_payload = que_posts.map { |p| { id: "#{p.id}", target: "#{p.target}", body: p.body } }
      { message: @@responses.que_routine(true, (cur_que_length - que_posts.length)), payload: { posts: posts_payload } }
    end

    private

    def readable_last_qrtine
      last_qrtine.strftime('%I:%M %p (%Z) on %D')
    end

    def status
      last = last_qrtine.nil? ? "The queue routine hasn't run yet" : readable_last_qrtine
      { message: "Online: there are currently #{posts.queued.length} in the Queue", payload: {
        total_queued: "#{posts.queued.length}",
        time_of_last: "#{last}",
        time_to_next: "#{cronfig.calc_time_to_next(last_qrtine)}"
      } }
    end

    def add_post_to_queue(payload)
      last = last_qrtine.nil? ? "The queue routine hasn't run yet" : readable_last_qrtine
      payload_info = { time_of_last: "#{last}", time_to_next: "#{cronfig.calc_time_to_next(last_qrtine)}" }
      new_post = posts.new({ id: payload[:id], target: payload[:target][:id], body: payload[:body] })
      if new_post.save
        { message: @@responses.add_post_to_queue(true, posts.queued.length), payload: payload_info }

      else
        { message: @@responses.add_post_to_queue(false, posts.queued.length), payload: payload_info }
      end
    end

    def remove_from_queue(target)
      case target
      when 'last'
        if posts.queued.sort_by(&:created_at).last.destroy
          { message: @@responses.remove_last(true) }
        else
          { message: @@responses.remove_last(false) }
        end

      when !target
        # no target path

      else # is an ID
        if posts.find(target).destroy
          { message:  @@responses.remove_post(true, target) }
        else
          { message:  @@responses.remove_post(false, target) }
        end
      end
    end

    # #CLASS
  end
  # #MODULE
end