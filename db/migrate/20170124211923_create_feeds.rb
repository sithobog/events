class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.references :user, index: true
      t.references :targetable, polymorphic: true, index: true
      t.text :message

      t.timestamps null: false
    end
  end
end
