Spree::Product.class_eval do

  def has_variant_with_price(price)
    variants.each do |variant|
      return true if variant.price == price
    end
    false
  end

  def has_variant_with_options(options)
    variants.each do |variant|
      return true if variant.option_values == options
    end
    false
  end
end
