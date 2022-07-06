module Quebert
  class RoutinesController < ActionController::API
    @@quebert = Quebert::Bot.all.first

    def que_routine
      render json: @@quebert.que_routine
    end
  end
end
