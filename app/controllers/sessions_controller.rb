class SessionsController < ApplicationController

  def create
    if login(params[:username], params[:password])
      redirect_to apps_path
    else
      flash.now[:alert] = "Unrecognized username / password combination."
      render action: :login
    end
  end

  def new
    render action: :login
  end

  def destroy
    logout
    redirect_to(root_path, notice: "Logged out.")
  end
end
