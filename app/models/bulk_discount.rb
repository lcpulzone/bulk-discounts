class BulkDiscount < ApplicationRecord
    belongs_to :merchant
    has_many :items, through: :merchant
    has_many :invoices, through: :merchant

    validates :percentage, presence: true, numericality: true
    validates :quantity_threshold, presence: true, numericality: true
end
