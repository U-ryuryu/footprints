class CreateCallComments < ActiveRecord::Migration[6.0]
  def change
    create_table :call_comments do |t|
      t.string     :comment,   null: false
      t.references :user,      foreign_key: true
      t.references :call,      foreign_key: true 
      t.timestamps
    end
  end
end
