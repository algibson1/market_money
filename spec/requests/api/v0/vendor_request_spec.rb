require "rails_helper"

RSpec.describe "Vendor API requests" do
  it "can return one vendor object + attributes" do
    new_vendor = create(:vendor)
    get "/api/v0/vendors/#{new_vendor.id}"

    expect(response).to be_successful
    expect(response.status).to eq(200)
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to have_key(:data)
    vendor = parsed_response[:data]

    expect(vendor).to have_key(:id)
    expect(vendor[:id]).to eq("#{new_vendor.id}")

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

  it "returns an error if vendor id is invalid" do
    get "/api/v0/vendors/453"

    expect(response.status).to eq(404)
    
    error = JSON.parse(response.body, symbolize_names: true)
    
    expect(error).to have_key(:errors)
    expect(error[:errors]).to be_an(Array)
    expect(error[:errors].count).to eq(1)
    expect(error[:errors].first).to be_a(Hash)
    expect(error[:errors].first).to have_key(:detail)
    expect(error[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=453")
  end

  context "post endpoint" do
    it "can create a new vendor" do
      post "/api/v0/vendors", params: {
        name: "Buzzy Bees",
        description: "Local honey and wax products",
        contact_name: "Berly Couwer",
        contact_phone: "8389928383",
        credit_accepted: false
      }
      
      expect(response).to be_successful
      expect(response.status).to eq(201)
  
      parsed = JSON.parse(response.body, symbolize_names: true)
      vendor = parsed[:data]
  
      vendor_object = Vendor.last
  
      expect(vendor).to have_key(:id)
      expect(vendor[:id]).to eq(vendor_object.id.to_s)
  
      expect(vendor).to have_key(:type)
      expect(vendor[:type]).to eq("vendor")
  
      expect(vendor).to have_key(:attributes)
      expect(vendor[:attributes]).to be_a(Hash)
  
      expect(vendor[:attributes]).to have_key(:name)
      expect(vendor[:attributes][:name]).to eq("Buzzy Bees")
  
      expect(vendor[:attributes]).to have_key(:description)
      expect(vendor[:attributes][:description]).to eq("Local honey and wax products")
  
      expect(vendor[:attributes]).to have_key(:contact_name)
      expect(vendor[:attributes][:contact_name]).to eq("Berly Couwer")
  
      expect(vendor[:attributes]).to have_key(:contact_phone)
      expect(vendor[:attributes][:contact_phone]).to eq("8389928383")
  
      expect(vendor[:attributes]).to have_key(:credit_accepted)
      expect(vendor[:attributes][:credit_accepted]).to eq(false)    
    end

    it "raises an error for a missing name or description" do
      post "/api/v0/vendors", params: {
        contact_name: "Berly Couwer",
        contact_phone: "8389928383",
        credit_accepted: true
      }

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expected_error =  {
        errors: [
          {
            detail: "Validation failed: Name can't be blank, Description can't be blank"
          }
        ]
      }

      expect(error).to eq(expected_error)
    end

    it "raises an error for a missing contact_name or phone" do
      post "/api/v0/vendors", params: {
        name: "Buzzy Bees",
        description: "Local honey and wax products",
        credit_accepted: true
      }

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expected_error =  {
        errors: [
          {
            detail: "Validation failed: Contact name can't be blank, Contact phone can't be blank"
          }
        ]
      }

      expect(error).to eq(expected_error)
    end

    it "raises an error for a missing credit accepted" do
      post "/api/v0/vendors", params: {
        name: "Buzzy Bees",
        description: "Local honey and wax products",
        contact_name: "Berly Couwer",
        contact_phone: "8389928383"
      }

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expected_error =  {
        errors: [
          {
            detail: "Validation failed: Credit accepted must be included as a true or false value"
          }
        ]
      }

      expect(error).to eq(expected_error)
    end
  end
end