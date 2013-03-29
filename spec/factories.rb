Factory.define :user do |user|
  user.nom                  "Andres"
  user.email                 "and_res-87@hotmail.com"
  user.password              "123456"
  user.password_confirmation "123456"
end

Factory.sequence :email do |n|
  "person-#{n}@exemple.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end 