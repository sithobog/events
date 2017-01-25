class CreateEventInvites < ActiveRecord::Migration
  def change
    create_table :event_invites do |t|
      t.references :event, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
