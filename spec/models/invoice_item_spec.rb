require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
    it { should have_many(:merchants).through(:item) }
    it { should have_many(:bulk_discounts).through(:merchants) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
  end

  describe 'enum' do
    it { should define_enum_for(:status) }
  end

  before :each do
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @antimerchant = Merchant.create!(name: 'TheOtherOne')

    @discount1 = BulkDiscount.create!(percentage: 10, quantity_threshold: 1, merchant_id: @merchant.id)
    @discount2 = BulkDiscount.create!(percentage: 20, quantity_threshold: 2, merchant_id: @merchant.id)
    @discount3 = BulkDiscount.create!(percentage: 30, quantity_threshold: 3, merchant_id: @merchant.id)

    @discount4 = BulkDiscount.create!(percentage: 40, quantity_threshold: 4, merchant_id: @antimerchant.id)
    @discount5 = BulkDiscount.create!(percentage: 50, quantity_threshold: 5, merchant_id: @antimerchant.id)
    @discount6 = BulkDiscount.create!(percentage: 60, quantity_threshold: 6, merchant_id: @antimerchant.id)

    @customer1 = Customer.create!(first_name: 'John', last_name: 'Smith')
    @customer2 = Customer.create!(first_name: 'Julie', last_name: 'Baker')
    @customer3 = Customer.create!(first_name: 'Jared', last_name: 'Lanata')
    @customer4 = Customer.create!(first_name: 'Jira', last_name: 'Mutiu')
    @customer5 = Customer.create!(first_name: 'Josephina', last_name: 'Cortez')
    @customer6 = Customer.create!(first_name: 'Jemma', last_name: 'Henry')

    @item1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant.id)
    @item2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant.id)
    @item3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, merchant_id: @merchant.id)
    @item4 = Item.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.2, merchant_id: @merchant.id)
    @item5 = Item.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.3, merchant_id: @merchant.id)
    @item6 = Item.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.4, merchant_id: @antimerchant.id)
    @item7 = Item.create!(name: 'Thing 7', description: 'This is the seventh thing.', unit_price: 9.5, merchant_id: @antimerchant.id)

    @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id, created_at: "2021-06-05 20:11:38.553871")
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer2.id, created_at: "2021-06-07 20:11:38.553871")
    @invoice3 = Invoice.create!(status: 1, customer_id: @customer3.id, created_at: "2021-06-06 20:11:38.553871")
    @invoice4 = Invoice.create!(status: 1, customer_id: @customer4.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice5 = Invoice.create!(status: 1, customer_id: @customer5.id, created_at: "2021-06-02 20:11:38.553871")
    @invoice6 = Invoice.create!(status: 1, customer_id: @customer6.id, created_at: "2021-06-03 20:11:38.553871")

    @invoice_item1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 2, invoice_id: @invoice1.id, item_id: @item1.id)
    @invoice_item2 = InvoiceItem.create!(quantity: 5, unit_price: 16.3, status: 1, invoice_id: @invoice1.id, item_id: @item2.id, created_at: "2021-06-05 20:11:38.553871")
    @invoice_item3 = InvoiceItem.create!(quantity: 4, unit_price: 19.4, status: 2, invoice_id: @invoice2.id, item_id: @item3.id)
    @invoice_item4 = InvoiceItem.create!(quantity: 1, unit_price: 12.2, status: 2, invoice_id: @invoice2.id, item_id: @item4.id)
    @invoice_item5 = InvoiceItem.create!(quantity: 2, unit_price: 10.4, status: 2, invoice_id: @invoice2.id, item_id: @item2.id)
    @invoice_item6 = InvoiceItem.create!(quantity: 7, unit_price: 15.3, status: 1, invoice_id: @invoice3.id, item_id: @item5.id, created_at: "2021-06-06 20:11:38.553871")
    @invoice_item7 = InvoiceItem.create!(quantity: 6, unit_price: 10.4, status: 2, invoice_id: @invoice3.id, item_id: @item3.id)
    @invoice_item8 = InvoiceItem.create!(quantity: 3, unit_price: 19.4, status: 1, invoice_id: @invoice4.id, item_id: @item3.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice_item9 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 1, invoice_id: @invoice5.id, item_id: @item5.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice_item10 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 2, invoice_id: @invoice6.id, item_id: @item6.id)
    @invoice_item11 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 1, invoice_id: @invoice4.id, item_id: @item1.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice_item12 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 2, invoice_id: @invoice4.id, item_id: @item2.id)
    @invoice_item13 = InvoiceItem.create!(quantity: 3, unit_price: 9.5, status: 2, invoice_id: @invoice6.id, item_id: @item7.id)

    @transaction1 = @invoice1.transactions.create!(result: 1, credit_card_number: 4654405418249632)
    @transaction2 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)
    @transaction3 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)
    @transaction4 = @invoice2.transactions.create!(result: 1, credit_card_number: 4923661117104166)
    @transaction5 = @invoice2.transactions.create!(result: 1, credit_card_number: 4515551623735617)
    @transaction6 = @invoice2.transactions.create!(result: 1, credit_card_number: 4515551623735617)
    @transaction7 = @invoice2.transactions.create!(result: 1, credit_card_number: 4515551623735607)
    @transaction8 = @invoice3.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction9 = @invoice4.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction10 = @invoice4.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    @transaction11 = @invoice5.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction12 = @invoice5.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    @transaction13 = @invoice5.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction14 = @invoice6.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    @transaction15 = @invoice6.transactions.create!(result: 0, credit_card_number: 4540842003561938)
    @transaction16 = @invoice6.transactions.create!(result: 0, credit_card_number: 4540842003561938)
    @transaction17 = @invoice6.transactions.create!(result: 0, credit_card_number: 4540842003561938)
  end

  describe '#item_name' do
    it 'can grab the item name associated with the item_id' do
      expect(@invoice_item1.item_name).to eq('Thing 1')
      expect(@invoice_item2.item_name).to eq('Thing 2')
    end
  end

  describe 'total revenue' do
    # it 'can turn the discount into a mathable percent' do
    #   expect(@discount1.turn_to_percent).to eq(0.10)
    # end

    it 'can find the best discount for an item' do
      expect(@invoice_item1.best_discount).to eq(@discount2)
      expect(@invoice_item1.best_discount).to_not eq(@discount1)
      expect(@invoice_item1.best_discount).to_not eq(@discount3)
    end

    it 'can give the invoice_item total' do
      expect(@invoice_item6.invoice_item_total).to eq(107.10)
    end

    it 'can find the discount total price' do
      expect(@invoice_item3.discount_total_price).to eq(54.32)
    end

    it 'can determine the total price for an item' do
      expect(@invoice_item2.total_item_sum).to eq(57.05)
      expect(@invoice_item2.total_item_sum).to_not eq(81.50)

      expect(@invoice_item13.total_item_sum).to eq(28.5)
      expect(@invoice_item13.total_item_sum).to_not eq(19.95)
    end
  end
end
