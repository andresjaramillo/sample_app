class UsersController < ApplicationController
  def new
    @titre = 'Inscription'
    @user = User.new
  end
  
   def show
    @user = User.find(params[:id])
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
  
end
