class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def after_sign_in_path_for(resource)
    account = resource.account
    request.env['omniauth.origin'] || stored_location_for(resource) || account_path(account)
  end
  
  def set_account
    if current_user
      @account = current_user.account
    else
      return redirect_to root_path, :alert => "Para acceder a esta Url es necesario estar autenticado en el sistema"
    end
  end
  
  def set_public_account
    unless @account = Account.where(id: params[:account_id]).first
      return redirect_to root_path, :alert => "La cuenta que busca no existe"
    end
  end
end
