namespace :deploy do
  desc "Deploy to integration server on Heroku"
  task :production => :environment  do
    `git push romiboweb master`
    `heroku run rake db:migrate -a romiboweb --remote production`
    `heroku run rake db:seed -a romiboweb --remote production`
  end

  desc "Deploy to integration server on Heroku"
  task :integration => :environment  do
    `git push romiboweb-integration master`
    `heroku run rake db:migrate -a romiboweb-integration --remote integration`
  end

  desc "Deploy to integration api server on Heroku"
  task :api => :environment  do
    `git push romibo-api master`
    `heroku run rake db:migrate -a romibo-api`
  end

  desc "Deploy to staging server on Heroku"
  task :staging => :environment do
    `git push romiboweb-staging master`
    `heroku run rake db:migrate -a romiboweb-staging --remote staging`
  end


  desc "Deploy to danny's server on Heroku"
  task :danny => :environment do
    `git push romiboweb-danny danny_branch:master`
    `heroku run rake db:migrate -a romiboweb-danny`
    'heroku run rake db:seed -a romiboweb-danny'
  end

  desc "Deploy to danny's server on Heroku, reload db"
  task :danny_clean => :environment do
    `git push romiboweb-danny danny_branch:master`
    `heroku run rake db:schema:load -a romiboweb-danny`
    'heroku run rake db:seed -a romiboweb-danny'
  end

  desc "Deploy to john's server on Heroku"
  task :danny => :environment do
    `git push romiboweb-john john_branch:master`
    `heroku run rake db:migrate -a romiboweb-john`
    'heroku run rake db:seed -a romiboweb-john'
  end

  desc "Deploy to john's server on Heroku"
  task :abhi => :environment do
    `git push romiboweb-abhi abhi_branch:master`
    `heroku run rake db:migrate -a romiboweb-abhi`
    'heroku run rake db:seed -a romiboweb-abhi'
  end
end

