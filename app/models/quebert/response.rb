module Quebert
  class Response < ApplicationRecord
    def self.remove_last(bool)
      bool ? 'The last post was successfully removed from the queue' : 'Could not find or remove the last post from the queue'
    end

    def self.remove_post(bool, id)
      bool ? "Post: ##{id} removed from queue" : "Couldn't locate post ##{id}"
    end

    def self.add_post_to_queue(bool, num)
      (bool ? 'Post added successfully queue. ' : 'Could not add post to queue. ') + "#{in_queue(num)}"
    end

    def self.in_queue(num)
      "#{num} post(s) currently queued."
    end

    def self.que_routine(bool, num)
      (bool ? 'Queue routine success: ' : 'No posts were sent: ') + "#{in_queue(num)}"
    end
  end
end
