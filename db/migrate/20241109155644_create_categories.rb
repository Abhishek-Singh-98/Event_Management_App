class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end


    create_table :categories_events, id: false do |t|
      t.belongs_to :category
      t.belongs_to :event
    end
  end
end
