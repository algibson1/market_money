require "rails_helper"

RSpec.describe StateSerializer do
  it "can format state info in a hash" do
    ca_market = create(:market, state: "California")
    create_list(:market_vendor, 40, market: ca_market)

    expected = { data: 
          [
            {
              state: "California",
              number_of_vendors: 40
            }
          ]
        }
    
    expect(StateSerializer.serialize(Vendor.popular_states)).to eq(expected)
  end

  it "works for multiple states" do
    ca_market = create(:market, state: "California")
    create_list(:market_vendor, 40, market: ca_market)
    co_market = create(:market, state: "Colorado")
    create_list(:market_vendor, 20, market: co_market)

    expected = { data: 
          [
            {
              state: "California",
              number_of_vendors: 40
            },
            {
              state: "Colorado",
              number_of_vendors: 20
            }
          ]
        }
    
    expect(StateSerializer.serialize(Vendor.popular_states)).to eq(expected)
  end
end