require 'spec_helper'

describe UsersController do
  render_views

  
  describe "GET 'show'" do

    before(:each) do
      @user = Factory(:user)
    end

    it "devrait reussir" do
      get :show, :id => @user
      response.should be_success
    end

    it "devrait trouver le bon utilisateur" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    
    it "devrait avoir le bon titre" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.nom)
    end

    it "devrait inclure le nom de l'utilisateur" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.nom)
    end

    it "devrait avoir une image de profil" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end
    
  end
  
  describe "GET 'new'" do
    
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "doit avoir le bon titre" do
        get :new
        response.should have_selector("title", :content=>"Inscription")
    end
    
  end
  
  describe "POST 'Create'" do
    
    describe "Echec" do
      
      before(:each) do
        @attr = {:nom => "", :email => "", :password => "",
                  :password_confirmation => ""}
      end
      
      it "ne devrait pas creer l'utilisateur"do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
      
      it "devrait avoir le bon titre" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Inscription")
      end

      it "devrait rendre la page 'new'" do
        post :create, :user => @attr
        response.should render_template('new')
      end
      
    end#describe "Echec"
    
    describe "Succes" do
      
      before(:each) do
        @attr = {:nom => "Andres", :email => "andres.jaramillo.o@gmail.com", :password => "elcomercio111",
                  :password_confirmation => "elcomercio111"}
      end
      
      it "devrait creer l'utilisateur" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
       it "devrait rediriger vers la page d'affichage de l'utilisateur" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end   
      
    end #describe "Succes"
    
  end#describe "Post 'Create'"

end
