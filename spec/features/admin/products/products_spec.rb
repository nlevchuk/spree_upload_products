require 'spec_helper'

describe 'Products', type: :feature do
  context 'as admin user' do
    stub_authorization!

    context 'uploading a file' do
      let(:file_path) { Rails.root + '../../spec/support/sample.csv' }

      it 'displays the upload button and redirect to the upload page after clicked on it' do
        visit spree.admin_products_path
        click_link Spree.t(:upload_from_file)
        expect(page.current_path).to eq(spree.upload_admin_products_path)
      end

      # it 'displays error message if file is empty' do
      #   visit spree.upload_admin_products_path
      #   click_button 'Create'
      #   expect(page).to have_content('select a file')
      # end

      it 'displays success message if no errors' do
        visit spree.upload_admin_products_path
        attach_file('product_file[file]', file_path)
        click_button 'Create'
        expect(page).to have_content('successfully added to queue')
      end
    end
  end
end
