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
end