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
end