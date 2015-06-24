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

#README
  run "rm README.rdoc"
  run "touch README.md"

#BOURBON
  if yes?("Do you want some Bourbon, Neat & Bitters? ")
      gem 'bourbon'
      gem 'neat'
      gem 'bitters'

      puts(set_color 'Creating application.scss', :blue, :bold)

      file 'app/assets/stylesheets/application.scss', <<-CODE
      @import 'bourbon';
      @import 'base/base';
      @import 'neat';
      CODE

      puts(set_color 'Removing old application.css', :blue, :bold)

      run('rm app/assets/stylesheets/application.css')

      puts(set_color 'Installing Bitters library', :blue, :bold )

      inside('app/assets/stylesheets') do
        run('bitters install')
      end

      puts(set_color 'Removing old _base.scss', :blue, :bold )

      run('rm app/assets/stylesheets/base/_base.scss')

      puts(set_color 'Creating _base.scss', :blue, :bold )

      file 'app/assets/stylesheets/base/_base.scss', <<-CODE
      @import "variables";
      @import "grid-settings";
      @import "buttons";
      @import "forms";
      @import "lists";
      @import "tables";
      @import "typography";
      CODE
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
