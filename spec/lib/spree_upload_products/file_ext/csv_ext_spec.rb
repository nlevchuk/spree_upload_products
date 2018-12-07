require 'spec_helper'

module SpreeUploadProducts
  module FileExt

    describe CsvExt do
      let(:file_path) { Rails.root + '../../spec/support/sample.csv' }
      subject { described_class.new(file_path) }

      it 'creates 3 products' do
        expect(Spree::Product.count).to eq(0)
        subject.parse
        expect(Spree::Product.count).to eq(3)
      end

      it 'create products with valid attributes' do
        subject.parse
        products = Spree::Product.order(:id)
        expect(products.first.name).to eq('Ruby on Rails Bag')
        expect(products.second.price.to_s).to eq('25.99')
        expect(products.third.total_on_hand).to eq(20)
      end

      it 'does not create duplicate products' do
        subject.parse
        expect(Spree::Product.count).to eq(3)

        subject.parse
        expect(Spree::Product.count).to eq(3)
      end
    end

  end
end
