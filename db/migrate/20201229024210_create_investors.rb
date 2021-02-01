class CreateInvestors < ActiveRecord::Migration[5.2]
  def change
    create_table :investors do |t|
      t.string :name
      t.text :description
      t.json :logo

      t.timestamps
    end
  end
end
