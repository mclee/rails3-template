# remove files
run "rm public/index.html"
run "cp config/database.yml config/database.yml.example"

# install gems
run "rm Gemfile"
file 'Gemfile', File.read("#{File.dirname(rails_template)}/Gemfile")

# bundle install
run "bundle install"

# database
rake "db:create"

# devise
run "rails g devise:install"
run "rails g devise User"
rake "db:migrate"
run "rails g devise:views"

# simple_form
run "rails g simple_form:install --bootstrap"

# generate rspec
#generate "rspec:install"

# copy files
# file 'script/watchr.rb', File.read("#{File.dirname(rails_template)}/watchr.rb")
run 'rm app/assets/javascripts/application.js'
file 'app/assets/javascripts/application.js', File.read("#{File.dirname(rails_template)}/app/assets/javascripts/application.js")
run 'rm app/assets/stylesheets/application.css'
file 'app/assets/stylesheets/application.css', File.read("#{File.dirname(rails_template)}/app/assets/stylesheets/application.css")
run 'rm app/assets/stylesheets/app_bootstrap.css.scss'
file 'app/assets/stylesheets/app_bootstrap.css.scss', File.read("#{File.dirname(rails_template)}/app/assets/stylesheets/app_bootstrap.css.scss")
file 'Guardfile', File.read("#{File.dirname(rails_template)}/Guardfile")

# remove active_resource and test_unit
gsub_file 'config/application.rb', /require 'rails\/all'/, <<-CODE
  require 'rails'
  require 'active_record/railtie'
  require 'action_controller/railtie'
  require 'action_mailer/railtie'
CODE

# add timezone
environment "config.time_zone = 'Asia/Shanghai'"

# .gitignore
append_file '.gitignore', <<-CODE
#----------------------------------------------------------------------------
# Ignore these files when commiting to a git repository.
#
# See http://help.github.com/ignore-files/ for more about ignoring files.
#
# The original version of this file is found here:
# https://github.com/RailsApps/rails-composer/blob/master/files/gitignore.txt
#
# Corrections? Improvements? Create a GitHub issue: 
# http://github.com/RailsApps/rails-composer/issues
#----------------------------------------------------------------------------

# bundler state
/.bundle
/vendor/bundle/
/vendor/ruby/

# minimal Rails specific artifacts
db/*.sqlite3
/log/*
/tmp/*

# various artifacts
**.war
*.rbc
*.sassc
.rspec
.redcar/
.sass-cache
/config/config.yml
/config/database.yml
/coverage.data
/coverage/
/db/*.javadb/
/db/*.sqlite3
/doc/api/
/doc/app/
/doc/features.html
/doc/specs.html
/public/cache
/public/stylesheets/compiled
/public/system/*
/spec/tmp/*
/cache
/capybara*
/capybara-*.html
/gems
/specifications
rerun.txt
pickle-email-*.html

# If you find yourself ignoring temporary files generated by your text editor
# or operating system, you probably want to add a global ignore instead:
#   git config --global core.excludesfile ~/.gitignore_global
#
# Here are some files you may want to ignore globally:

# scm revert files
**.orig

# Mac finder artifacts
.DS_Store

# Netbeans project directory
/nbproject/

# RubyMine project files
.idea

# Textmate project files
/*.tmproj

# vim artifacts
**.swp
CODE

# keep tmp and log
run "touch tmp/.gitkeep"
run "touch log/.gitkeep"

# git commit
git :init
git :add => '.'
git :add => 'tmp/.gitkeep -f'
git :add => 'log/.gitkeep -f'
git :commit => "-a -m 'initial commit'"
