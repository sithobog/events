class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime   :date
      t.string     :place
      t.string     :purpose
      t.text       :description
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
