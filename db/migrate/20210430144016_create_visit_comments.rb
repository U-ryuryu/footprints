class CreateVisitComments < ActiveRecord::Migration[6.0]
  def change
    create_table :visit_comments do |t|
      t.string     :comment,   null: false
      t.references :user,      foreign_key: true
      t.references :visit,    foreign_key: true 
      t.timestamps
    end
  end
end
