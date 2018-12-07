require 'spree_upload_products/file_ext/base'
require 'csv'

module SpreeUploadProducts
  module FileExt
    class CsvExt < Base
      def parse
        index = 0
        CSV.foreach(@path, { col_sep: /\;/ }) do |row|
          if (index == 0)
            index += 1
            next
          end
          index += 1
          splitted_row = row.first.split(/\;/)
          tmp, name, description, price, availability_date, slug, stock_total, category = splitted_row
          next if name.nil? || Spree::Product.where(slug: slug).present?
          options = {
            product: {
              name: name, description: description, price: convert_to_float(price),
              available_on: availability_date, slug: slug
            },
            taxon: { name: category },
            stock_item: { count_on_hand: stock_total }
          }
          create_entities(options)
        end
      end

      private

      def convert_to_float(value)
        value.gsub(',', '.').to_f
      end
    end
  end
end
