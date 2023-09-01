class Vendor < ApplicationRecord
  has_many :market_vendors, dependent: :destroy
  has_many :markets, through: :market_vendors
  validates_presence_of :name,
                        :description,
                        :contact_name,
                        :contact_phone
  validates :credit_accepted, inclusion: {in: [true, false], message: "cannot be left blank"}

  def states_sold_in
    markets.pluck(:state).uniq
  end
end