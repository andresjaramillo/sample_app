# encoding: UTF-8
require 'spec_helper'

describe "une inscription" do
  
  describe "ratee" do
    it "ne devrait pas creer un nouvel utilisateur" do
      lambda do
        visit signup_path
        fill_in "Nom",  :with => ""
        fill_in "Email", :with => ""
        fill_in "Password", :with => ""
        fill_in "Confirmation", :with => ""
        click_button
        response.should render_template('users/new')
        response.should have_selector("div#error_explanation")
      end.should_not change(User, :count)
    end
  end
  
  describe "Reussie" do
    it "devrait creer un nouvel utilisateur" do
      lambda do
        visit signup_path
        fill_in "Nom",  :with => "Andres Jaramillo"
        fill_in "Email", :with => "andres.jaramillo.o@gmail.com"
        fill_in "Password", :with => "elcomercio111"
        fill_in "Confirmation", :with => "elcomercio111"
        click_button

        response.should have_selector("div.flash.success", 
                                      :content => "Bienvenue")
        response.should render_template('users/show')
      end.should change(User, :count).by(1)
    end
  end
  
   describe "Identification/déconnexion" do
    describe "l'échec" do
      it "ne devrait pas identifier l'utilisateur" do
        visit signin_path
        fill_in :email,    :with => ""
        fill_in :password, :with => ""
        click_button
        response.should have_selector("div.flash.error", :content => "Combinaison")
      end
    end
    
    describe "le succès" do
      it "devrait identifier un utilisateur puis le déconnecter" do
        user = Factory(:user)
        visit signin_path
        fill_in :email,    :with => user.email
        fill_in :password, :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Deconnexion"
        controller.should_not be_signed_in
      end
    end
  end
  
  
end
