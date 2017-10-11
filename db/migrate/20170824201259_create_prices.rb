class CreatePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :prices do |t|
      t.references :flight, foreign_key: true
      t.string :price

      t.timestamps
    end
  end
end
