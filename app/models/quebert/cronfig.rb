module Quebert
  class Cronfig < ApplicationRecord
    belongs_to :bot

    def handle_slash_command(params)
      command = params[:command]
      payload = params[:payload]

      case command
      when nil # GET current cronfig since they are nil on a get request
        { message: readable_cronfig(current_cronfig),
          payload: { days:, hours:, minutes:, seconds:, runImmediately: run_on_start } }
      when 'config'
        binding.pry
      else
        binding.pry
        { error: "#{command} : command not recognized." }
      end
    end

    def current_cronfig
      [days, hours, minutes, seconds]
    end

    def cron_units
      %w[days hours minutes seconds]
    end

    def elapsed_seconds(tim_one, tim_two = false)
      tim_one ||= Time.now
      tim_two ||= Time.now
      (tim_one - tim_two).to_i.abs
    end

    def seconds_to_cronfig(seconds) # [d,h,m,s]
      [24, 60, 60].reverse.each_with_object([seconds]) do |unitsize, result|
        result[0, 0] = result.shift.divmod(unitsize)
      end
    end

    def cronfig_to_seconds
      [86_400, 3600, 60, 1].zip(current_cronfig).map { |arr| arr[0] * arr[1] }.sum
    end

    def readable_cronfig(cron) # '1 days 1 hours 1 minutes 1 seconds'
      cron.map.with_index { |n, i| n === 0 ? next : "#{n} #{cron_units[i]}" }.compact.join(' ')
    end

    def calc_time_to_next(last)
      cronfig_until = seconds_to_cronfig((cronfig_to_seconds - elapsed_seconds(last)))
      readable_cronfig(cronfig_until)
    end

    ## CLASS
  end
  ## MODULE
end