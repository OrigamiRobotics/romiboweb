class AddAdminColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false

    execute "UPDATE users
            SET admin=TRUE
            WHERE email IN
           ( 'jadekwan8@gmail.com',
             'nartey_brown@yahoo.com',
             'jaredwpeters@gmail.com',
             'aubreyshick@gmail.com'
           )"

  end
end
