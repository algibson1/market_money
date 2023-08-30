require "rails_helper"

RSpec.describe ErrorSerializer do
  it "formats not_found error messages" do
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

    expect(ErrorSerializer.not_found(error)).to eq(expected)
  end

  it "formats invalid error messages" do
    vendor = Vendor.new({
      contact_name: "Berly Couwer",
      contact_phone: "8389928383",
      credit_accepted: true
    })
  
    vendor.save
    expected =  {
      "errors": [
        {
          "detail": "Validation failed: Name can't be blank, Description can't be blank"
        }
      ]
    }

    expect(ErrorSerializer.invalid(vendor.errors)).to eq(expected)
  end
end