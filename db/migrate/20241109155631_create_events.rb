class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :location
      t.datetime :start_time
      t.datetime :end_time
      t.integer :max_capacity, default: 0
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
