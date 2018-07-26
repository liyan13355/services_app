class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name
      t.string :service
      t.string :email
      t.string :country
      t.integer :price

      t.timestamps
    end
  end
end
