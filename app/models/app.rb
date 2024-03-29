class App < ActiveRecord::Base
  attr_accessible :name, :user_id

  belongs_to :user

  def reboot!
    Overseer.new(name, user.api_key).reboot!
  end
end
