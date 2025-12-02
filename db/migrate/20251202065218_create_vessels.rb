class CreateVessels < ActiveRecord::Migration[8.1]
  def change
    create_table :vessels do |t|
      t.string :name, null: false
      t.references :shipping_line, null: false, foreign_key: true

      t.timestamps
    end
  end
end
