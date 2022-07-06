module Quebert
  class CommandsController < ActionController::API
    @@quebert = Quebert::Bot.all.first

    ## POST => /slash-command
    def slash_command
      render json: @@quebert.handle_slash_command(params)
    end

    ## GET/POST => /cronfig
    def cronfig
      render json: @@quebert.cronfig.handle_slash_command(params)
    end
  end
end