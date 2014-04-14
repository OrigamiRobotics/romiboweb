namespace :data do

  desc "Set admin users"
  task :set_admin_users => :environment do
    my_sql = "UPDATE users
              SET admin=TRUE
              WHERE email IN
              ( 'jadekwan8@gmail.com',
                  'nartey_brown@yahoo.com',
                  'jaredwpeters@gmail.com',
                  'aubreyshick@gmail.com'
              )"
    ActiveRecord::Base.connection.execute(my_sql)
  end
end

