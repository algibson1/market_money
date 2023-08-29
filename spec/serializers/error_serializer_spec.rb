require "rails_helper"

RSpec.describe ErrorSerializer do
  it "formats error messages" do
    begin
      market = Market.find(3)
    rescue ActiveRecord::RecordNotFound => error
      error
    end

    expected = { 
      errors: 
        [detail: 
          error.message
        ]
      }

    expect(ErrorSerializer.format_error(error)).to eq(expected)
  end
end