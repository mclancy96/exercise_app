class Workout < ApplicationRecord
  belongs_to :routine
  DAY_OF_WEEK = %i[sunday monday tuesday wednesday thursday friday saturday].freeze

  def day_of_week_name
    DAY_OF_WEEK[day_of_week] if day_of_week
  end
end
