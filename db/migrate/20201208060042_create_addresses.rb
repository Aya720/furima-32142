class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :order,            foreign_key: true
      t.string :zip,                  null: false
      t.integer :prefecture_id,       null: false
      t.string :city,                 null: false
      t.string :street,               null: false
      t.string :apartment
      t.string :phone,                null: false
      t.timestamps
    end
  end
end
