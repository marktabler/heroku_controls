class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :username, :email, :password, :password_confirmation, :raw_api_key

  attr_accessor :raw_api_key

  before_save :set_encrypted_api_key

  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

  def api_key
    Encryptor.decrypt(value: encrypted_api_key, key: ENV['HEROKU_CONTROLS_SECRET_KEY'])
  end

  def set_encrypted_api_key
    if @raw_api_key
      self.encrypted_api_key = Encryptor.encrypt(value: @raw_api_key, key: ENV['HEROKU_CONTROLS_SECRET_KEY'])
    end
  end
end
