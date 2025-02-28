class CreateCompaniesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :registry_number, null: false
      t.string :name, null: false
      t.string :city, null: false
      t.timestamps
    end

    enable_extension 'pg_trgm'

    add_index(:companies, :registry_number, using: 'gin', opclass: 'gin_trgm_ops')
    add_index(:companies, :name, using: 'gin', opclass: 'gin_trgm_ops')
    add_index(:companies, :city, using: 'gin', opclass: 'gin_trgm_ops')
  end
end
