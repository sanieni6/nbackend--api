class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :age, :integer
    add_column :users, :image, :string
    add_column :users, :status, :string, default: 'Activo'
    add_column :users, :phone_number, :string
    add_column :users, :birthday, :datetime
    add_column :users, :marital_status, :string
    add_column :users, :observation, :text
  end
end
