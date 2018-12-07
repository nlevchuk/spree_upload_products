Spree::Core::Engine.add_routes do
  get 'admin/products/upload', to: 'admin/product_files#new', as: 'upload_admin_products'
  post 'admin/products/upload', to: 'admin/product_files#create'
end
