require 'rails_helper'

RSpec.describe 'Admin Dashboard Index Page' do
  before :each do
    @customer1 = Customer.create!(first_name: "Dr.", last_name: "Pepper")
    @customer2 = Customer.create!(first_name: "Lil", last_name: "Boosie")
    @customer3 = Customer.create!(first_name: "Snoop", last_name: "Dizzy")
    @customer4 = Customer.create!(first_name: "Michael", last_name: "Jordan")
    @customer5 = Customer.create!(first_name: "Lebron", last_name: "James")
    @customer6 = Customer.create!(first_name: "Mike", last_name: "Vick")
    @invoice1 = @customer1.invoices.create!(status: 2)
    @invoice2 = @customer2.invoices.create!(status: 2)
    @invoice3 = @customer3.invoices.create!(status: 2)
    @invoice4 = @customer4.invoices.create!(status: 2)
    @invoice5 = @customer5.invoices.create!(status: 2)
    @invoice6 = @customer6.invoices.create!(status: 2)

    # customer 1 - third
    @transaction1 = @invoice1.transactions.create!(result: 1, credit_card_number: 4654405418249632)
    @transaction2 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)
    @transaction3 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)
    # customer 2 - second
    @transaction4 = @invoice2.transactions.create!(result: 1, credit_card_number: 4923661117104166)
    @transaction5 = @invoice2.transactions.create!(result: 1, credit_card_number: 4515551623735617)
    @transaction6 = @invoice2.transactions.create!(result: 1, credit_card_number: 4515551623735617)
    @transaction7 = @invoice2.transactions.create!(result: 1, credit_card_number: 4515551623735607)
    # customer 3 - fifth
    @transaction8 = @invoice3.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    # customer 4 - sixth
    @transaction9 = @invoice4.transactions.create!(result: 0, credit_card_number: 4203696133194408)
    @transaction10 = @invoice4.transactions.create!(result: 0, credit_card_number: 4540842003561938)
    # customer 5 - fourth
    @transaction11 = @invoice5.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction12 = @invoice5.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    # customer 6 - first
    @transaction13 = @invoice6.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction14 = @invoice6.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    @transaction15 = @invoice6.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    @transaction16 = @invoice6.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    @transaction17 = @invoice6.transactions.create!(result: 1, credit_card_number: 4540842003561938)

    # visit "/admin"
    visit dashboard_index_path
  end

  it 'I see a header indicating that I am on the admin dashboard' do
    expect(page).to have_content('Admin Dashboard')
  end

  it "Then I see a link to the admin merchants & invoices index page" do
    expect(page).to have_link('Admin Merchant Index Page', href: admin_merchants_path)
    expect(page).to have_link('Admin Invoice Index Page', href: admin_invoices_path)
  end

  it "I see the names of the top 5 customers by successful transactions" do
    expect(current_path).to eq(dashboard_index_path)

    within("#top-customer-#{@customer6.id}") do
      expect(page).to have_content(@customer6.first_name)
      expect(page).to have_content(@customer6.last_name)
    end

    within("#top-customer-#{@customer2.id}") do
      expect(page).to have_content(@customer2.first_name)
      expect(page).to have_content(@customer2.last_name)
    end

    within("#top-customer-#{@customer1.id}") do
      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.last_name)
    end

    within("#top-customer-#{@customer5.id}") do
      expect(page).to have_content(@customer5.first_name)
      expect(page).to have_content(@customer5.last_name)
    end

    within("#top-customer-#{@customer3.id}") do
      expect(page).to have_content(@customer3.first_name)
      expect(page).to have_content(@customer3.last_name)
    end
  end

  it "next to each customer name I see the number of their successful transactions" do
    expect(current_path).to eq(dashboard_index_path)

    within("#top-customer-#{@customer6.id}") do
      expect(page).to have_content(@customer6.number_of_successful_transactions)
    end

    within("#top-customer-#{@customer2.id}") do
      expect(page).to have_content(@customer2.number_of_successful_transactions)
    end

    within("#top-customer-#{@customer1.id}") do
      expect(page).to have_content(@customer1.number_of_successful_transactions)
    end

    within("#top-customer-#{@customer5.id}") do
      expect(page).to have_content(@customer5.number_of_successful_transactions)
    end

    within("#top-customer-#{@customer3.id}") do
      expect(page).to have_content(@customer3.number_of_successful_transactions)
    end
  end

  it "I see a list of the ids of all invoices that have items that have not yet been shipped" do
    @customer1 = Customer.create!(first_name: "Dr.", last_name: "Pepper")
    invoice1 = @customer1.invoices.create!(status: 2)
    @merchant1 = Merchant.create!(name: "Billy", status: 1)
    item1 = @merchant1.items.create!(name: "shoes", description: "super fast boi, can't catch me boi", unit_price: 60.00, status: 1)
    6.times do |item1|
      item1
    end
    6.times do |invoice1|
      invoice1
    end
    @invoice_item1 = item1.invoice_items.create!(quantity: 6, unit_price: 3.0, status: 0, invoice: invoice1)
    @invoice_item2 = item1.invoice_items.create!(quantity: 1, unit_price: 400.0, status: 2, invoice: invoice1)
    @invoice_item3 = item1.invoice_items.create!(quantity: 3, unit_price: 45.0, status: 1, invoice: invoice1)
    @invoice_item4 = item1.invoice_items.create!(quantity: 5, unit_price: 18.0, status: 1, invoice: invoice1)
    @invoice_item5 = item1.invoice_items.create!(quantity: 1, unit_price: 67.0, status: 2, invoice: invoice1)
    @invoice_item6 = item1.invoice_items.create!(quantity: 2, unit_price: 250.0, status: 2, invoice: invoice1)

    expect(current_path).to eq(dashboard_index_path)

    within("#incomplete-invoices-#{invoice1.id}") do
      expect(page).to have_content(invoice1.id)
    end
  end
end
