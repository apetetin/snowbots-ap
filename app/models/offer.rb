class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :domain
  belongs_to :order

  def total_price(diff_days)
    self.car_price + self.flat_price_by_night * diff_days
  end
end
