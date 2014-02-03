namespace :deploy do
  desc "Deploy to integration api server on Heroku"
  task :integration do
    `git push romiboweb-integration master`
    `heroku run rake db:migrate -a romiboweb-integration --remote integration`
  end

  desc "Deploy to production server on Heroku"
  task :production do
    `git push heroku master`
    `heroku run rake db:migrate -a funcationer --remote production`
  end
end

