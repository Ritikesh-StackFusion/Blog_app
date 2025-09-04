require 'httparty'

class FirebaseClient
  include HTTParty

  def initialize(database_url, database_secret = nil)
    @base_uri = database_url.chomp('/')
    @auth = database_secret ? "?auth=#{database_secret}" : ""
  end

  def write_data(path, data)
    url = "#{@base_uri}/#{path}.json#{@auth}"
    self.class.put(url, body: data.to_json)
  end

  def read_data(path)
    url = "#{@base_uri}/#{path}.json#{@auth}"
    response = self.class.get(url)
    JSON.parse(response.body)
  end

  def delete_data(path)
    url = "#{@base_uri}/#{path}.json#{@auth}"
    self.class.delete(url)
  end
end