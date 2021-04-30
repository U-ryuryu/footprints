class CreateVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :visits do |t|
      t.string     :title,     null: false
      t.datetime   :date,      null: false
      t.string     :content,   null: false
      t.integer    :status_id, null: false
      t.references :user,      foreign_key: true
      t.references :client,    foreign_key: true 
      t.timestamps
    end
  end
end
