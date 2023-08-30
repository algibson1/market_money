class ErrorSerializer
  def self.not_found(error)
    { errors: [
        {
          detail: error.message
        }
      ]
    }
  end


  def self.invalid(errors)
    { errors: [
      {
        detail: "Validation failed: #{errors.full_messages.join(", ")}"
      }
    ]
  }
  end

  def self.no_association(ids)
    {
      errors: [
          {
              detail: "No association exists between market with 'id'=#{ids["market_id"] || "N/A"} AND vendor with 'id'=#{ids["vendor_id"] || "N/A"}"
          }
      ]
  }
  end
end