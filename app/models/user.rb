class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :apps

  attr_accessible :username, :email, :password, :password_confirmation, :raw_api_key
  attr_accessor :raw_api_key

  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

  before_save :set_encrypted_api_key


  def api_key
    if encrypted_api_key.present?
      Encryptor.decrypt(value: Base64.decode64(encrypted_api_key).encode('ascii-8bit'), key: ENV['HEROKU_CONTROLS_SECRET_KEY'])
    end
  end

  def set_encrypted_api_key
    if @raw_api_key.present?
      base_encryption = Encryptor.encrypt(value: @raw_api_key, key: ENV['HEROKU_CONTROLS_SECRET_KEY'])
      self.encrypted_api_key = Base64.encode64(base_encryption).encode('utf-8')
    end
  end
end
