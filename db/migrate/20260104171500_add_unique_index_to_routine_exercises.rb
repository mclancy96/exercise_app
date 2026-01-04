class AddUniqueIndexToRoutineExercises < ActiveRecord::Migration[8.0]
  def up
    # Remove duplicate routine_exercises rows, keeping the one with the smallest id
    execute <<-SQL.squish
      DELETE FROM routine_exercises
      WHERE id NOT IN (
        SELECT MIN(id) FROM routine_exercises
        GROUP BY routine_id, exercise_id, day_of_week
      )
    SQL

    add_index :routine_exercises, %i[routine_id exercise_id day_of_week], unique: true,
                                                                          name: "index_routine_ex_on_routine_exercise_day"
  end

  def down
    remove_index :routine_exercises, name: "index_routine_ex_on_routine_exercise_day"
  end
end
