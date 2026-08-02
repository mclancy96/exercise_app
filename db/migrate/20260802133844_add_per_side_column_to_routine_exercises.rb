class AddPerSideColumnToRoutineExercises < ActiveRecord::Migration[8.0]
  def change
    add_column :routine_exercises, :per_side, :boolean, default: false, null: false
  end
end
