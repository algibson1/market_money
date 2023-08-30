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
end