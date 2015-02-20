Deface::Override.new(
  virtual_path: 'spree/admin/variants/_form',
  name:         'add hidden to edit page',
  insert_after:   "[data-hook='admin_variant_form_additional_fields']",
  text: '<div data-hook="hidden">
      <%= f.check_box :hidden %>
      <%= f.label :hidden, Spree.t(:hidden) %>
    </div>'
)
