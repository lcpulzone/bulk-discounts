require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:bulk_discounts).through(:merchants) }
  end

  describe 'validations' do
    it { should define_enum_for(:status) }
  end

  before :each do
    # Below set up is for Admin side
    @merchant1 = Merchant.create!(name: "Tyler", status: 1)
    @merchant2 = Merchant.create!(name: "Jill", status: 1)
    @merchant3 = Merchant.create!(name: "Bob", status: 1)
    @merchant4 = Merchant.create!(name: "Johnny", status: 0)
    @merchant5 = Merchant.create!(name: "Carrot Top", status: 0)
    @merchant6 = Merchant.create!(name: "lil boosie", status: 0)

    @item1 = @merchant1.items.create!(name: "socks", description: "soft", unit_price: 3.00, status: 0)
    @item2 = @merchant2.items.create!(name: "watch", description: "bling-blang", unit_price: 400.00, status: 0)
    @item3 = @merchant3.items.create!(name: "skillet", description: "HOT!", unit_price: 45.00, status: 0)
    @item4 = @merchant4.items.create!(name: "3 Pack of Shirts", description: "comfy", unit_price: 18.00, status: 0)
    @item5 = @merchant5.items.create!(name: "shoes", description: "woah, fast boi!", unit_price: 67.00, status: 0)
    @item6 = @merchant6.items.create!(name: "dress", description: "brown-chicken-black-cow", unit_price: 250.00, status: 0)

    @customer1 = Customer.create!(first_name: "Dr.", last_name: "Pepper")

    @invoice1 = @customer1.invoices.create!(status: 2, created_at: "2012-03-21 09:54:09")
    @invoice2 = @customer1.invoices.create!(status: 2, created_at: "2012-04-21 09:54:09")
    @invoice3 = @customer1.invoices.create!(status: 2, created_at: "2012-05-21 09:54:09")

    @transaction1 = @invoice1.transactions.create!(result: 1, credit_card_number: 4654405418249632)
    @transaction2 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)

    @transaction3 = @invoice2.transactions.create!(result: 1, credit_card_number: 4923661117104166)
    @transaction4 = @invoice2.transactions.create!(result: 0, credit_card_number: 4515551623735607)

    @transaction5 = @invoice3.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction6 = @invoice3.transactions.create!(result: 1, credit_card_number: 4540842003561938)

    @invoice_item1 = @item1.invoice_items.create!(quantity: 6, unit_price: 3.0, status: 1, invoice: @invoice1)
    @invoice_item2 = @item2.invoice_items.create!(quantity: 1, unit_price: 400.0, status: 1, invoice: @invoice1)
    @invoice_item3 = @item3.invoice_items.create!(quantity: 3, unit_price: 45.0, status: 1, invoice: @invoice2)
    @invoice_item4 = @item4.invoice_items.create!(quantity: 5, unit_price: 18.0, status: 0, invoice: @invoice2)
    @invoice_item5 = @item5.invoice_items.create!(quantity: 1, unit_price: 67.0, status: 2, invoice: @invoice3)
    @invoice_item6 = @item6.invoice_items.create!(quantity: 2, unit_price: 250.0, status: 2, invoice: @invoice3)

    # Below set up is for Merchant side
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @customer = Customer.create!(first_name: 'John', last_name: 'Smith')
    @item_1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant.id)
    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer.id, created_at: "2021-06-05 20:11:38.553871" )
    @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 2, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 5, unit_price: 16.3, status: 2, invoice_id: @invoice_1.id, item_id: @item_2.id)

    # Gunnar's Tests
    @customer9 = Customer.create!(first_name: "Bobby", last_name: "Mendez")
    @invoice9 = Invoice.create!(status: 1, customer_id: @customer9.id)
    @merchant9 = Merchant.create!(name: "Nike")
    @item9 = Item.create!(name: "Kobe zoom 5's", description: "Best shoe in basketball hands down!", unit_price: 12500, merchant_id: @merchant9.id)
    @invoice_item9 = InvoiceItem.create!(quantity: 2, unit_price: 25000, status: 2, invoice_id: @invoice9.id, item_id: @item9.id)
  end

  describe 'instance methods' do
    describe '#unshipped' do
      it 'returns all invoices that are unshipped ordered from oldest to newest' do
        expected = [@invoice2, @invoice1]
        not_expected = [@invoice1, @invoice2]

        expect(Invoice.unshipped).to eq(expected)
        expect(Invoice.unshipped).to_not eq(not_expected)
      end
    end

    describe '#convert_create_date' do
      it 'making a date in readable fashion' do
        expect(@invoice_1.convert_create_date).to eq("Saturday, June 05, 2021")
      end

    describe '#merchant_total_revenue'
      it 'can give the total revenue for a merchants items on specific invoice' do
        expect(@invoice_1.merchant_total_revenue(@merchant.id)).to eq(111.3)
      end
    end

    describe '#total_revenue' do
      it 'total revenue for an invoice' do
        expect(@invoice9.total_revenue).to eq(50000)
      end
    end

    # describe '.class methods' do
    #   it 'can give an invoice creation date' do
    #     expect(Invoice.invoice_creation(@item1).present?).to eq(true)
    #   end
    # end
  end

  describe 'bulk discounts' do
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

    it 'can give revenue total with discount if it applies' do
      expect(@invoice1.invoice_revenue_with_discounts).to eq(80.89)
    end
  end
end
