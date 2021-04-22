class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :name,        null: false
      t.string :tel,         null: false
      t.string :postal_code, null: false
      t.string :address,     null: false
      t.string :charge
      t.string :charge_tel
      t.references :admin,   foreign_key: true
      t.timestamps
    end
  end
end
