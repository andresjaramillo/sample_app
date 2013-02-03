# encoding: UTF-8
# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nom        :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
require 'spec_helper'

describe User do

  before (:each) do
    @attr = { :nom => "example", 
              :email => "user@exemple.com",
              :password => "foobar",
              :password_confirmation => "foobar" 
             }
  end
  
  it "devrait creer une nouvelle instance des attributs valides" do
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
    long_nom = "andres"*10
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
  
  describe "password validations" do

    it "devrait exiger un mot de passe" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "devrait exiger une confirmation du mot de passe qui correspond" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "devrait rejeter les mots de passe (trop) courts" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "devrait rejeter les (trop) longs mots de passe" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end
  
  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "devrait avoir un attribut  mot de passe crypte" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "devrait definir le mot de passe encrypte" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "Methode has_password?" do
     
      it "doit retourner true si les mots de passe coincident" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "doit retourner false si les mots de passe divergent" do
        @user.has_password?('invalide').should be_false
      end
      
    end#password encryption
    
  end#password validations
  
  describe "Atrribut admin" do
    before (:each) do
      @user = User.create!(@attr)
    end
    
    it "devrait confirmer l'exitence de 'admin'" do
      @user.should respond_to(:admin)
    end
    
    it "ne devrait pas être un administrateur par défaut" do
      @user.should_not be_admin
    end
    
    it "devrait pouvoir devenir un administrateur" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
    
  end
  
end#describe user
