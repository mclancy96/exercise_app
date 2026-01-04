class CreateExercises < ActiveRecord::Migration[8.0]
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :sets
      t.integer :reps
      t.string :rep_unit
      t.string :description

      t.timestamps
    end
  end
end
