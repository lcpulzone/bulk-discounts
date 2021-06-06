class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: { cancelled: 0, in_progress: 1, completed: 2}, _prefix: :status


  def self.unshipped
    joins(:invoice_items).group(:id).where.not(invoice_items: {status: 2}).order(:id)
  end
end
