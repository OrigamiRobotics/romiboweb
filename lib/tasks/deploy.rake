namespace :deploy do
  desc "Deploy to integration api server on Heroku"
  task :integration do
    `git push heroku romiboweb-integration`
    `heroku run rake db:migrate -a romiboweb-integration`
  end

  desc "Deploy to production server on Heroku"
  task :production do
    `git push heroku master`
    `heroku run rake db:migrate -a romiboweb --remote`
  end
end

