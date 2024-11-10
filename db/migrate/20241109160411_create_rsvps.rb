class CreateRsvps < ActiveRecord::Migration[7.0]
  def change
    create_table :rsvps do |t|
      t.integer :status
      t.datetime :rsvp_date
      t.references :user
      t.references :event
      t.timestamps
    end
  end
end
