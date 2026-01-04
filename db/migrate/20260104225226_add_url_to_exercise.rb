class AddUrlToExercise < ActiveRecord::Migration[8.0]
  def change
    add_column :exercises, :url, :string
  end
end
