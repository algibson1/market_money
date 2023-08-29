class MarketSerializer 
  include JSONAPI::Serializer
  attributes  :name,
              :street,
              :city,
              :county,
              :state,
              :zip,
              :lat,
              :lon,
              :vendor_count


  # def self.format_markets(markets)
  #   markets.map do |market|
  #     { 
  #       id: market.id,
  #       type: "market",
  #       attributes: {
  #         name: market.name,
  #         street: market.street,
  #         city: market.city,
  #         county: market.county,
  #         state: market.state,
  #         zip: market.zip,
  #         lat: market.lat,
  #         lon: market.lon,
  #         vendor_count: market.vendor_count
  #     }}
  #   end
  # end

  # def self.format_market(market)
  #   { 
  #     id: market.id,
  #     type: "market",
  #     attributes: {
  #       name: market.name,
  #       street: market.street,
  #       city: market.city,
  #       county: market.county,
  #       state: market.state,
  #       zip: market.zip,
  #       lat: market.lat,
  #       lon: market.lon,
  #       vendor_count: market.vendor_count
  #   }}
  # end
end