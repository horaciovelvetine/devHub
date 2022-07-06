module Quebert
  class Post < ApplicationRecord
    belongs_to :bot

    scope :queued, -> { where(queued: true) }
    scope :posted, -> { where(queued: false) }
  end
end