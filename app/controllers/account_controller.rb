class AccountController < ApplicationController
  def index
    if current_user
      redirect_to account_path(current_user.account)
    end
  end
  
  def show
    @account = current_user.account
  end
end
