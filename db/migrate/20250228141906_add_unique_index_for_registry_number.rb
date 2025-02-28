class AddUniqueIndexForRegistryNumber < ActiveRecord::Migration[7.0]
  def change
    add_index :companies, :registry_number, unique: true, using: 'btree', name: 'index_companies_on_registry_number_unique'
  end
end
