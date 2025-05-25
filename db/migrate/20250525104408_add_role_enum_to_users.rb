class AddRoleEnumToUsers < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      CREATE TYPE user_role AS ENUM ('user', 'admin');
    SQL
    
    remove_column :users, :role
    add_column :users, :role, :user_role, default: 'user'
  end

  def down
    remove_column :users, :role
    add_column :users, :role, :integer
    
    execute <<-SQL
      DROP TYPE user_role;
    SQL
  end
end
