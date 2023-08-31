class TomtomService
  def atm_search(market)
    Faraday.get("https://api.tomtom.com/search/2/nearbySearch/.json") do |f|
      f.params[:lat] = market.lat
      f.params[:lon] = market.lon
      f.params[:radius] = 10000
      f.params[:categorySet] = 7397
      f.params[:key] = Rails.application.credentials.tomtom[:key]
    end
  end

  # def format_atms
  #   response = JSON.parse(atm_search.body, symbolize_names: true)
  #   response[:results].map do |atm|
  #     { distance: atm[:distance], #calculated in meters... change to miles? Or other?
  #       name: atm[:poi][:name],
  #       address: atm[:address], #still a nested hash
  #       lat: atm[:position][:lat],
  #       lon: atm[:position][:lon]
  #     }
  #   end
  # end
end