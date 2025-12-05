class CreateFiscalProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :fiscal_profiles do |t|
      t.string :razon_social, null: false
      t.string :rfc, null: false, limit: 13
      t.string :regimen, null: false
      t.string :uso_cfdi, null: false
      t.string :forma_pago, null: false
      t.string :metodo_pago, null: false

      t.timestamps
    end

    add_index :fiscal_profiles, :rfc, unique: true
  end
end
