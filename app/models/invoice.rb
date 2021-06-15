class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: { cancelled: 0, in_progress: 1, completed: 2}, _prefix: :status

  def total_revenue
    invoice_items.sum("quantity * unit_price")
  end

  def number_status
    status_before_type_cast
  end

  def self.unshipped
    joins(:invoice_items).group(:id).where.not(invoice_items: {status: 2}).order(created_at: :desc)
  end

  def convert_create_date
    self.created_at.strftime("%A, %B %d, %Y")
  end

  def status_for_view
    rev_statuses = {0 => 'cancelled', 1 => 'in_progress', 2 => 'completed'}
    rev_statuses[self.status]
  end

  def merchant_total_revenue(merchant_id)
    Invoice.joins(:items, :invoice_items)
    .where('items.merchant_id = ?', merchant_id)
    .where('invoices.id = ?', self.id)
    .distinct
    .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def self.invoice_creation(item)
    joins(:merchants, :items, :invoice_items)
    .where('invoice_items.item_id = ?', item.id)
    .where('merchants.id = ?', item.merchant_id)
    .where('invoice_items.status = ?', 1).select('invoices.created_at')
    .pluck(:created_at)
    .strftime("%A, %B %d, %Y")
  end

  def invoice_revenue_with_discounts
    price = invoice_items.map do |item|
      item.total_item_sum
    end
    price.sum
  end
end
