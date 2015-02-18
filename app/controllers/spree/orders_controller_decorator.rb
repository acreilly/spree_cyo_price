Spree::OrdersController.class_eval do
  before_action :check_cyo_price, only: [:populate]

  def populate
    binding.pry
    populator = Spree::OrderPopulator.new(current_order(create_order_if_necessary: true), current_currency)

    if populator.populate(params[:variant_id], params[:quantity])
      respond_with(@order) do |format|
        format.html { redirect_to cart_path }
      end
    else
      flash[:error] = populator.errors.full_messages.join(" ")
      redirect_back_or_default(spree.root_path)
    end
  end


  def check_cyo_price
    if Spree::Variant.find(params.try(:[], :variant_id))
      product = Spree::Variant.find(params[:variant_id]).product
      if product.cyo_price # consider is_master
        variant = Spree::Variant.find(params[:variant_id])

        binding.pry
      end
    end
  end
end