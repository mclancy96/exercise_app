class CreateWorkouts < ActiveRecord::Migration[8.0]
  def change
    create_table :workouts do |t|
      t.references :routine, null: false, foreign_key: true
      t.string :day_of_week
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
