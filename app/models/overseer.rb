class Overseer
  include HTTParty

  attr_accessor :app_name, :api_key

  def initialize(app_name, api_key)
    @app_name = app_name
    @api_key = api_key
  end

  def auth
    {username: '', password: @api_key}
  end

  def reboot!
    HTTParty.post("https://api.heroku.com/apps/#{@app_name}/ps/restart", :basic_auth => auth, format: :json, output: 'json' )
  end
end