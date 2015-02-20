Spree::OrdersController.class_eval do
  before_action :check_cyo_price, only: [:populate]

  def populate
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
    custom_price = BigDecimal.new(params[:cyo_price_field].split(" ")[1])

    if product.cyo_price && product.price <= custom_price
      variant = Spree::Variant.find(params[:variant_id])

      if product.has_variant_with_price(custom_price) && product.has_variant_with_options(variant.option_values)

        product.variants.map{|v| [v.price, v.id, v.option_values]}.each do |v|
            return params[:variant_id] = Spree::Variant.find(v[1]).id if v[0] == custom_price && v[2] == variant.option_values
        end
          false
      else
        new_variant = Spree::Variant.create(product: product, price: custom_price, option_values: variant.option_values, images: variant.images, hidden: true)

        params[:variant_id] = new_variant.id
      end
    else
      flash[:error] = "Minimum price is #{product.display_price.to_s}."
      redirect_back_or_default(spree.root_path)
    end
  end
end
