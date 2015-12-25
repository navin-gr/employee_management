class AddProfileImageToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :profile_image, :string
  end
end
