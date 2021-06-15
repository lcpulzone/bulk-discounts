class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  has_many :bulk_discounts, through: :merchants

  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true

  enum status: { pending: 0, packaged: 1, shipped: 2}, _prefix: :status

  def item_name
    self.item.name
  end

  def status_for_view
    rev_statuses = {0 => 'Pending', 1 => 'Packaged', 2 => 'Shipped'}
    rev_statuses[self.status]
  end

  def self.invoice_id(item)
    joins(:merchants, :item, :invoice).where('invoice_items.item_id = ?', item.id).where('merchants.id = ?', item.merchant_id).where('invoice_items.status = ?', 1).select('invoice_items.invoice_id').pluck(:invoice_id).first
  end

  def best_discount
    bulk_discounts.where('quantity_threshold <= ?', quantity)
    .order(percentage: :desc)
    .first
  end

  def invoice_item_total
    (quantity * unit_price).round(2)
  end

  def discount_total_price
    price = ((invoice_item_total * best_discount.turn_to_percent) - invoice_item_total).abs
    price.round(2)
  end

  def total_item_sum
    if best_discount.blank?
      invoice_item_total
    else
      discount_total_price
    end
  end
end
