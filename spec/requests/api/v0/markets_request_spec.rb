require "rails_helper"

RSpec.describe "Markets API" do
  it "returns a list of all markets" do
    create_list(:market, 5)

    get "/api/v0/markets" 

    expect(response).to be_successful

    markets = JSON.parse(response.body)
  
    expect(markets["data"].count).to eq(5)

    markets["data"].each do |market|
      expect(market).to have_key("id")
      expect(market["id"]).to be_an(Integer)

      expect(market).to have_key("name")
      expect(market["name"]).to be_a(String)

      expect(market).to have_key("street")
      expect(market["street"]).to be_a(String)

      expect(market).to have_key("city")
      expect(market["city"]).to be_a(String)

      expect(market).to have_key("county")
      expect(market["county"]).to be_a(String)

      expect(market).to have_key("state")
      expect(market["state"]).to be_a(String)

      expect(market).to have_key("zip")
      expect(market["zip"]).to be_a(String)

      expect(market).to have_key("lat")
      expect(market["lat"]).to be_a(String)

      expect(market).to have_key("lon")
      expect(market["lon"]).to be_a(String)

      expect(market).to have_key("vendor_count")
      expect(market["vendor_count"]).to be_an(Integer)
    end
  end


  xit "returns one market by id" do
    create(:market, id: 35)

    get "/api/v0/markets/35"

    expect(response).to be_successful
  end
end