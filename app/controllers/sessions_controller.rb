# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  def new
    @titre = "S'identifier"
  end
  
  def create
    user = User.authentificate(params[:session][:email],
                               params[:session][:password])
    if user.nil?
      flash.now[:error] = "Combinaison e-mail/mot de passe invalide"
      @titre = "S'identifier"
      render 'new'
    else
      sign_in user
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
