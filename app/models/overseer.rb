class Overseer
  include HTTParty
  base_uri 'https://api.heroku.com'
  default_params :output => 'json'
  format :json

  attr_accessor :app_name, :api_key

  def initialize(app_name, api_key)
    @app_name = app_name
    @api_key = key
  end

  def auth
    {username: '', key: @api_key}
  end

  def reboot!
    post("/apps/#{@app_name}/ps/restart", :basic_auth => auth )
  end
end