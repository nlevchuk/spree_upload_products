module SpreeUploadProducts
  module FileExt
    class Base
      def initialize(path)
        @path = path
      end

      private

      def create_entities(options)
        shipping_category = Spree::ShippingCategory.find_or_create_by!(name: 'Default')
        Spree::StockLocation.find_or_create_by!(name: 'default')

        product = Spree::Product.create!(
          options[:product].merge(shipping_category: shipping_category)
        )

        taxonomy = Spree::Taxonomy.find_or_create_by!(name: 'Categories')
        taxon = Spree::Taxon.find_or_create_by!(
          options[:taxon].merge(taxonomy: taxonomy, parent_id: taxonomy.id)
        )
        Spree::Classification.create!(product_id: product.id, taxon_id: taxon.id)

        product.stock_items.first.update_attributes!(options[:stock_item])
      end
    end
  end
end
