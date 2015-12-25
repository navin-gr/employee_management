class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :designation
      t.string :mentor

      t.timestamps null: false
    end
  end
end
