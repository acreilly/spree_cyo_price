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
    product = Spree::Variant.find(params.try(:[], :variant_id)).product
    if product.cyo_price
      variant = Spree::Variant.find(params[:variant_id])
      custom_price = BigDecimal.new(params[:cyo_price_field])
      if product.has_variant_with_price(custom_price)
        binding.pry
          # Are there other variants
        else
          # Displaying variants on frontend, will need to create method for variants to check if it should be up there
          new_variant = Spree::Variant.create(product: product, price: BigDecimal.new(params[:cyo_price_field]), option_values: variant.option_values, images: variant.images)

          params[:variant_id] = new_variant.id
        end
          # At end of everything set params[:variant_id] to new variant
        end
      end
    end
  end