require "rails_helper"

RSpec.describe "Markets API" do
  it "returns one market by id" do
    create(:market, id: 35)

    get "/api/v0/markets/35"

    expect(response).to be_successful
  end
end