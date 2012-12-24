class AppsController < ApplicationController

  before_filter :require_login
  before_filter :find_app, only: [:destroy, :reboot]

  def index
    @apps = current_user.apps
  end

  def new
    @app = App.new
  end

  def create
    @app = current_user.apps.create!(params[:app])
    redirect_to apps_path
  end

  def destroy
    @app.destroy
    redirect_to apps_path
  end

  def reboot
    response = @app.reboot!
    if response.headers['status'] =~ /200/
      flash[:notice] = "App successfully rebooted!"
    else
      flash[:error] = "App was not rebooted; status code #{response.headers['status']}"
    end
    redirect_to apps_path
  end

  def find_app
    @app = current_user.apps.find(params[:id])
  end

end
