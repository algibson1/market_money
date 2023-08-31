require "rails_helper"

RSpec.describe MarketSearch do
  it "initializes with state, city, and name" do
    search = MarketSearch.new({"state" => "California", "city" => "San Francisco", "name" => "Orange Fair"})

    expect(search.state).to eq("California")
    expect(search.city).to eq("San Francisco")
    expect(search.name).to eq("Orange Fair")
  end

  describe "validations" do
    it "is always valid when state is passed in" do
      search1 = MarketSearch.new({"state" => "California"})
      search2 = MarketSearch.new({"state" => "California", "city" => "San Francisco"})
      search3 = MarketSearch.new({"state" => "California", "city" => "San Francisco", "name" => "Orange Fair"})
      search4 = MarketSearch.new({"state" => "California", "name" => "Orange Fair"})

      expect(search1.valid?).to eq(true)
      expect(search2.valid?).to eq(true)
      expect(search3.valid?).to eq(true)
      expect(search4.valid?).to eq(true)
    end

    it "is not valid if city is passed without a state" do
      search1 = MarketSearch.new({"city" => "San Francisco", "name" => "Orange Fair"})
      search2 = MarketSearch.new({"city" => "San Francisco"})
      
      expect(search1.valid?).to eq(false)
      expect(search2.valid?).to eq(false)
    end

    it "is valid even if only name is passed" do
      search = MarketSearch.new({"name" => "Orange Fair"})

      expect(search.valid?).to eq(true)
    end
  end

  it "can make a query sql" do
    search = MarketSearch.new({"state" => "California", "city" => "San Francisco", "name" => "Orange Fair"})

    expect(search.query_sql).to eq("LOWER(state) LIKE LOWER(?) AND LOWER(city) LIKE LOWER(?) AND LOWER(name) LIKE LOWER(?)")
  end

  it "can render queries" do
    search1 = MarketSearch.new({"state" => "California", "city" => "San Francisco", "name" => "Orange Fair"})
    search2 = MarketSearch.new({"state" => "California", "name" => "Orange Fair"})
    
    expect(search1.render_queries).to eq(["LOWER(state) LIKE LOWER(?) AND LOWER(city) LIKE LOWER(?) AND LOWER(name) LIKE LOWER(?)", "%California%", "%San Francisco%", "%Orange Fair%"])
    expect(search2.render_queries).to eq(["LOWER(state) LIKE LOWER(?) AND LOWER(name) LIKE LOWER(?)", "%California%", "%Orange Fair%"])

    market = create(:market, state: "California", city: "San Francisco", name: "Orange Fair")

    expect(Market.where(search1.render_queries)).to include(market)
    expect(Market.where(search2.render_queries)).to include(market)
  end
end