class Overseer
  include HTTParty
  base_uri 'https://api.heroku.com'
  basic_auth '', ENV['HEROKU_API_KEY']
  default_params :output => 'json'
  format :json

  attr_accessor :app_name

  def initialize(app_name)
    @app_name = app_name
  end

  def self.reboot!
    post("/apps/#{@app_name}/ps/restart")
  end
end