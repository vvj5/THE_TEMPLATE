#Rails TIY template

#Add heroku procfile
file('Procfile',  "web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}")

#Add ruby version to gemfile
ruby_version = ask("What is your ruby version? ")
insert_into_file "Gemfile", "ruby '#{ruby_version}'", :after => "source 'https://rubygems.org'\n"

#Add pg and puma gem
  gem 'pg'
  gem 'puma'

#RAILS 12 FACTOR
gem_group :production do
  gem 'rails_12factor'
end

#FAKER
gem_group :development, :test do
  gem 'faker'
end

#PAGINATE
  gem 'will_paginate', '~> 3.0.7'
end

#README
  run "rm README.rdoc"
  run "touch README.md"

#MATERIALIZE
  if yes?("Do you want to use Materialize CSS? ")
      gem 'materialize-sass'
  end

#REACT
  if yes?("Do you want to use React? ")
    gem 'react-rails'
    run 'rails g react:install'
  end

#BCRYPT
  if yes?("Do you want to use bcrypt? ")
    gem 'bcrypt'
  end
