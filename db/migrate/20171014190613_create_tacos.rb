class CreateTacos < ActiveRecord::Migration[5.1]
  def change
    create_table :tacos do |t|
      t.string :name
      t.boolean :spicy
      t.boolean :double_tortilla
      t.string :meat

      t.timestamps
    end
  end
end
