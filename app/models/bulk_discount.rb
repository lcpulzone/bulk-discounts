class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoices, through: :merchant
  has_many :invoice_items, through: :invoices

  validates :percentage, presence: true, numericality: true
  validates :quantity_threshold, presence: true, numericality: true

  def turn_to_percent
    ((percentage.to_f) / 100)
  end
end
