class CreatePorts < ActiveRecord::Migration[8.1]
  def change
    create_table :ports do |t|
      t.string :name, null: false
      t.string :country, null: false
      t.string :uncode

      t.timestamps
    end
  end
end
