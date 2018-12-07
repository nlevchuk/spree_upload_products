require 'spree_core'
require 'spree_extension'
require 'sidekiq'

require 'spree_upload_products/engine'
require 'spree_upload_products/version'
require 'spree_upload_products/uploader'
require 'spree_upload_products/errors'
require 'spree_upload_products/job'

require 'spree_upload_products/file_ext/csv_ext'

module SpreeUploadProducts
  CONTENT_TYPES_AND_CONSTS = {
    'text/csv' => FileExt::CsvExt
  }
end
