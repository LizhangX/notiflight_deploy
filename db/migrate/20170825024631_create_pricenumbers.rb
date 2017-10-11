class CreatePricenumbers < ActiveRecord::Migration[5.1]
  def change
    create_table :pricenumbers do |t|
      t.integer :price
      t.references :flight, foreign_key: true

      t.timestamps
    end
  end
end
