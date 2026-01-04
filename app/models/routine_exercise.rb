class RoutineExercise < ApplicationRecord
  belongs_to :routine
  belongs_to :exercise
  validates :exercise_id, presence: true
  validates :day_of_week, presence: true
  validates :routine_id, presence: true

  validates :exercise_id,
            uniqueness: { scope: %i[routine_id day_of_week],
                          message: "has already been added to this routine for that day" }
end
