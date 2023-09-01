require "rails_helper" 

RSpec.describe Vendor do
  describe "relationships" do
    it { should have_many :market_vendors }
    it { should have_many :markets }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :contact_name }
    it { should validate_presence_of :contact_phone }
    it { should allow_value(true).for(:credit_accepted) }
    it { should allow_value(false).for(:credit_accepted) }
    it { should_not allow_value(nil).for(:credit_accepted) }
  end

  it "can return number of states that vendor sells in" do
    vendor = create(:vendor)
    m1 = create(:market, state: "Colorado")
    m2 = create(:market, state: "California")
    m3 = create(:market, state: "Oregon")

    create(:market_vendor, market: m1, vendor: vendor)
    create(:market_vendor, market: m2, vendor: vendor)
    create(:market_vendor, market: m3, vendor: vendor)

    expect(vendor.states_sold_in).to eq(["Colorado", "California", "Oregon"])
  end

  it "can return all vendors who sell in more than one state, ordered by states_sold_in" do
    market1 = create(:market, state: "Alabama")
    market2 = create(:market, state: "Alaska")
    market3 = create(:market, state: "Arizona")
    market4 = create(:market, state: "Arkansas")
    market5 = create(:market, state: "California")
    market6 = create(:market, state: "Colorado")
    vendor1 = create(:vendor)
    vendor2 = create(:vendor)
    vendor3 = create(:vendor)
    vendor4 = create(:vendor)
    vendor5 = create(:vendor)
    vendor6 = create(:vendor)

    MarketVendor.create(market: market1, vendor: vendor1)
    MarketVendor.create(market: market2, vendor: vendor1)
    MarketVendor.create(market: market3, vendor: vendor1)
    MarketVendor.create(market: market4, vendor: vendor1)
    MarketVendor.create(market: market5, vendor: vendor1)
    MarketVendor.create(market: market6, vendor: vendor1)
    
    MarketVendor.create(market: market1, vendor: vendor5)
    MarketVendor.create(market: market2, vendor: vendor5)
    MarketVendor.create(market: market3, vendor: vendor5)
    MarketVendor.create(market: market4, vendor: vendor5)
    MarketVendor.create(market: market5, vendor: vendor5)

    MarketVendor.create(market: market1, vendor: vendor3)
    MarketVendor.create(market: market2, vendor: vendor3)
    MarketVendor.create(market: market3, vendor: vendor3)

    MarketVendor.create(market: market1, vendor: vendor4)
    MarketVendor.create(market: market2, vendor: vendor4)
    MarketVendor.create(market: market3, vendor: vendor4)
    MarketVendor.create(market: market4, vendor: vendor4)

    MarketVendor.create(market: market1, vendor: vendor2)

    MarketVendor.create(market: market1, vendor: vendor6)

    expect(Vendor.multiple_states).to eq([vendor1, vendor5, vendor4, vendor3])
  end

  it "can report all states and how many vendors sell there" do
    ca_market = create(:market, state: "California")
    co_market = create(:market, state: "Colorado")
    pa_market = create(:market, state: "Pennsylvania")
    ny_market = create(:market, state: "New York")
    al_market = create(:market, state: "Alabama")

    create_list(:market_vendor, 10, market: ca_market)
    create_list(:market_vendor, 29, market: co_market)
    create_list(:market_vendor, 15, market: pa_market)
    create_list(:market_vendor, 31, market: ny_market)
    create_list(:market_vendor, 5, market: al_market)

    states = Vendor.popular_states
    expect(states[0].state).to eq("New York")
    expect(states[0].number_of_vendors).to eq(31)

    expect(states[1].state).to eq("Colorado")
    expect(states[1].number_of_vendors).to eq(29)

    expect(states[2].state).to eq("Pennsylvania")
    expect(states[2].number_of_vendors).to eq(15)

    expect(states[3].state).to eq("California")
    expect(states[3].number_of_vendors).to eq(10)

    expect(states[4].state).to eq("Alabama")
    expect(states[4].number_of_vendors).to eq(5)
  end

  it "can take in an optional limit for top popular states" do
    ca_market = create(:market, state: "California")
    co_market = create(:market, state: "Colorado")
    pa_market = create(:market, state: "Pennsylvania")
    ny_market = create(:market, state: "New York")
    al_market = create(:market, state: "Alabama")

    create_list(:market_vendor, 10, market: ca_market)
    create_list(:market_vendor, 29, market: co_market)
    create_list(:market_vendor, 15, market: pa_market)
    create_list(:market_vendor, 31, market: ny_market)
    create_list(:market_vendor, 5, market: al_market)

    states = Vendor.popular_states(3)

    names = states.map { |state| state.state }
    expect(names).to eq(["New York", "Colorado", "Pennsylvania"])
  end
end