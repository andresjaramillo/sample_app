# -*- encoding : utf-8 -*-

class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :currect_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  def index
    @titre = "Liste des utilisateurs"
    #@users = User.all
    @users = User.paginate(:page => params[:page])
  end
  
  def new
    @titre = 'Inscription'
    @user = User.new
  end
  
   def show
    @user = User.find_by_id(params[:id])
    @titre = @user.nom
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Bienvenue"+ @user.nom
      redirect_to @user
    else
      @titre = "Inscription"
      render 'new'
    end
  end
  
  def edit
   # @user = User.find(params[:id])
    @titre = "Édition profil"
  end
  
  def update 
   # @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profil actualisé"
      redirect_to @user
    else
      @titre = "Édition profil"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Utilisateur supprimé"
    redirect_to users_path
  end
  
 private
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
  
  def authenticate 
    dany_access unless signed_in?
  end
  
  def currect_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
