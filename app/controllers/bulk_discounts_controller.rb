class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts

    response = Faraday.get 'https://date.nager.at/api/v2/NextPublicHolidays/us'
    parsed = JSON.parse(response.body, symbolize_names: true)
    @holidays = parsed[0..2]
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.bulk_discounts.new({
      percentage: params[:percentage],
      quantity_threshold: params[:quantity_threshold]
      })

    if discount.save
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
    else
      flash[:error] = "Error: #{error_message(discount.errors)}"
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/new"
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
    @discount.update(discount_params)

    if @discount.save
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/#{@discount.id}"
      flash[:notice] = "Discount has been successfully updated, YAY!"
    else
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/#{@discount.id}/edit"
      flash[:error] = "Error: #{error_message(@discount.errors)}"
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.find(params[:id]).destroy
    redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
  end

  private
  def discount_params
    params.permit(:percentage, :quantity_threshold)
  end
end
