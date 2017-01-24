class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author
      t.text   :content
      t.references :event, index: true

      t.timestamps null: false
    end
  end
end
