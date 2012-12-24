#This is a dirty monkey patch, but Heroku's API does not return valid JSON and
#MultiJson chokes on it.

module HTTParty
  class Parser
    def json
      MultiJson.decode(body) rescue body
    end
  end
end
