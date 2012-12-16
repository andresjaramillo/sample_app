require 'spec_helper'

describe PagesController do

render_views

  describe "GET 'home'" do

    it "devrait reussir" do
      get 'home'
      response.should be_success
    end
    
      it "doit avoir le bon titre" do
        get 'home'
        response.should have_selector("title", :content=>" | Accueil")
      end
   
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
     
     it "doit avoir le bon titre" do
        get 'contact'
        response.should have_selector("title",:content => " | Contact")
      end
  end
  
  describe "GET 'about'" do
      it "Devrait reussir - about" do
        get 'about'
        response.should be_success
      end
     
      it "doit avoir le bon titre" do
        get 'about'
        response.should have_selector("title",:content => " | A propos")
      end
   end
end
