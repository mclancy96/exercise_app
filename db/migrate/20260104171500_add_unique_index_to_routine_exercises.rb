class AddUniqueIndexToRoutineExercises < ActiveRecord::Migration[8.0]
  def change
    add_index :routine_exercises, %i[routine_id exercise_id day_of_week], unique: true,
                                                                          name: "index_routine_ex_on_routine_exercise_day"
  end
end
