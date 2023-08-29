require "rails_helper"

RSpec.describe "Market Vendor Requests" do
  it "returns a list of vendors belonging to a given market" do
    market1 = create(:market)
    market2 = create(:market)

    market_1_vendors = create_list(:market_vendor, 7, market: market1)
    market_2_vendors = create_list(:market_vendor, 8, market: market2)

    get "/api/v0/markets/#{market1.id}/vendors"

    expect(response).to be_successful
    expect(response.status).to eq(200)
    vendors1 = JSON.parse(response.body, symbolize_names: true)

    get "/api/v0/markets/#{market2.id}/vendors"

    expect(response).to be_successful
    expect(response.status).to eq(200)
    vendors2 = JSON.parse(response.body, symbolize_names: true)

    expect(vendors1).to have_key(:data)
    expect(vendors1[:data].count).to eq(7)
    expect(vendors2[:data].count).to eq(8)

    vendors1[:data].each do |vendor|
      expect(vendor).to have_key(:id)
      expect(vendor[:id]).to be_a(String)

      expect(vendor).to have_key(:type)
      expect(vendor[:type]).to eq("vendor")

      expect(vendor).to have_key(:attributes)
      expect(vendor[:attributes]).to be_a(Hash)

      expect(vendor[:attributes]).to have_key(:name)
      expect(vendor[:attributes][:name]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:description)
      expect(vendor[:attributes][:description]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:contact_name)
      expect(vendor[:attributes][:contact_name]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:contact_phone)
      expect(vendor[:attributes][:contact_phone]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:credit_accepted)
      expect(vendor[:attributes][:credit_accepted]).to eq(true).or eq(false)
    end
  end

  it "throws an error if market id is invalid" do
    get "/api/v0/markets/534/vendors"

    expect(response.status).to eq(404)
    
    error = JSON.parse(response.body, symbolize_names: true)
    
    expect(error).to have_key(:errors)
    expect(error[:errors]).to be_an(Array)
    expect(error[:errors].count).to eq(1)
    expect(error[:errors].first).to be_a(Hash)
    expect(error[:errors].first).to have_key(:detail)
    expect(error[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=534")
  end
end