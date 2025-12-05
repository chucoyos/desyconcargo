class CreateAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :addresses do |t|
      t.string :name, null: false
      t.string :country, null: false, limit: 2
      t.string :postal_code, null: false, limit: 5
      t.string :state, null: false
      t.string :municipality
      t.string :colony
      t.string :street
      t.string :exterior_number
      t.string :interior_number
      t.string :email

      t.timestamps
    end

    add_index :addresses, [ :country, :state, :municipality ]
    add_index :addresses, :postal_code
  end
end
