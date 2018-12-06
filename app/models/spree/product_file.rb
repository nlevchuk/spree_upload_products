module Spree
  class ProductFile
    include ActiveModel::AttributeMethods
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :file
    attr_reader :errors

    def initialize
      @errors = ActiveModel::Errors.new(self)
    end

    def persisted?
      false
    end
  end
end
