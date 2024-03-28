class MarketService 		
  def initialize; end		
      
  def call_db(url, params = {})		
    response = connection.get(url) do |request| 		
      request.params = params		
      request.params[:api_key] = Rails.application.credentials.movie[:key]		
    end		
    JSON.parse(response.body, symbolize_names: true)		
  end		
      
  private		
      
  def connection		
    Faraday.new('base_url')		
  end
end