Deface::Override.new(
  virtual_path: 'spree/admin/products/_form',
  name:         'add cyo_price to edit page',
  insert_after:   "[data-hook='admin_product_form_cost_currency']",
  text: '<div data-hook="admin_product_form_cyo_price">
      <%= f.check_box :cyo_price %>
      <%= f.label :cyo_price, Spree.t(:cyo_price) %>
    </div>'
)
