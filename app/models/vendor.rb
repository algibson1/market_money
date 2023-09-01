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

  def self.multiple_states
    Vendor.joins(:markets)
      .select("vendors.*, COUNT(DISTINCT markets.state) as state_count")
      .group("vendors.id")
      .having("COUNT(DISTINCT markets.state) > 1")
      .order(state_count: :desc)
  end
end