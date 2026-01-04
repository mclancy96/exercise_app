class AddOrderColumnToRoutineExercises < ActiveRecord::Migration[8.0]
  def change
    add_column :routine_exercises, :order, :integer, default: 0, null: false
  end
end
