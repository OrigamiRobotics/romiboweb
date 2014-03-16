namespace :deploy do
  desc "Deploy to integration server on Heroku"
  task :integration do
    `git push romiboweb-integration master`
    `heroku run rake db:migrate -a romiboweb-integration --remote integration`
  end

  desc "Deploy to integration api server on Heroku"
  task :api do
    `git push romibo-api master`
    `heroku run rake db:migrate -a romibo-api`
  end

  desc "Deploy to staging server on Heroku"
  task :staging do
    `git push romiboweb-staging master`
    `heroku run rake db:migrate -a romiboweb-staging --remote staging`
  end

  desc "Deploy to production server on Heroku"
  task :production do
    `git push heroku master`
    `heroku run rake db:migrate -a romiboweb --remote`
  end
end

