# -*- encoding : utf-8 -*-
require 'faker'

namespace :db do
  desc "Peupler la base de données"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
  end
end

def make_users
  administrateur = User.create!(:nom => "Utilisateur exemple",
                      :email => "example@railstutorial.org",
                      :password => "foobar",
                      :password_confirmation => "foobar")
    administrateur.toggle!(:admin)
    99.times do |n|
      nom  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "motdepasse"
      User.create!(:nom => nom,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
                   
   end
end
    
def make_microposts   
  User.all(:limit => 6).each do |user|
    45.times do
      user.microposts.create!(:content => Faker::Lorem.sentence(5))    
    end
  end
end

