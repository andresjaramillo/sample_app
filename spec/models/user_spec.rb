# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nom        :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
    
  before (:each) do
    @attr = { :nom => "example", :email => "user@exemple.com" }
  end
  
  it "devrait creer une nouvelle instance" do
    User.create!(@attr)
  end
  #Pour que ce test marque nous avons décommenté user.db le validate
  it "devrait exiger un nom" do 
    bad_user = User.new(@attr.merge(:nom => ""))
    bad_user.should_not be_valid
  end
  
  it "devrait exiger un e-mail" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "devrait regeter les noms trop long 10 caracteres" do
    long_nom = "andresandresandres"
    long_nom_user = User.new(@attr.merge(:nom => long_nom))
    long_nom_user.should_not be_valid
  end
  
  it "devrait rejeter l'adresse e-mail" do
    adresse = %w[user@foo,com user_at_foo.org example.user@foo.]
    adresse.each do |adress|
      invalid_email_user = User.new(@attr.merge(:email => adress))
      invalid_email_user.should_not be_valid
    end
  end  
  
  it "devrait rejeter l'adresse e-mail double" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "devrait rejeter une adresse email invalide jusqu'a la casse" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
end
