Deface::Override.new(
  virtual_path: 'spree/admin/products/index',
  name: 'add_upload_button_to_admin_products_index',
  insert_after: "erb[loud]:contains('button_link_to Spree.t(:new_product)')",
  text: "
    <%= button_link_to Spree.t(:upload_from_file), upload_admin_products_url,
                       { class: 'btn-success', id: 'admin_upload_products' } %>
  "
)
