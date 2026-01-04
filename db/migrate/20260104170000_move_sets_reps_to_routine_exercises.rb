class MoveSetsRepsToRoutineExercises < ActiveRecord::Migration[8.0]
  def up
    add_column :routine_exercises, :sets, :integer
    add_column :routine_exercises, :reps, :integer
    add_column :routine_exercises, :rep_unit, :string

    # Copy data from exercises to routine_exercises where possible
    say_with_time "Copying sets/reps/rep_unit from exercises to routine_exercises" do
      execute(<<~SQL)
        UPDATE routine_exercises
        SET sets = exercises.sets,
            reps = exercises.reps,
            rep_unit = exercises.rep_unit
        FROM exercises
        WHERE routine_exercises.exercise_id = exercises.id
      SQL
    end

    remove_column :exercises, :sets
    remove_column :exercises, :reps
    remove_column :exercises, :rep_unit
  end

  def down
    add_column :exercises, :sets, :integer
    add_column :exercises, :reps, :integer
    add_column :exercises, :rep_unit, :string

    say_with_time "Copying sets/reps/rep_unit back from routine_exercises to exercises" do
      execute(<<~SQL)
        UPDATE exercises
        SET sets = sub.sets,
            reps = sub.reps,
            rep_unit = sub.rep_unit
        FROM (
          SELECT exercise_id, sets, reps, rep_unit
          FROM routine_exercises
          WHERE exercise_id IS NOT NULL
          LIMIT 1
        ) sub
        WHERE exercises.id = sub.exercise_id
      SQL
    end

    remove_column :routine_exercises, :sets
    remove_column :routine_exercises, :reps
    remove_column :routine_exercises, :rep_unit
  end
end
