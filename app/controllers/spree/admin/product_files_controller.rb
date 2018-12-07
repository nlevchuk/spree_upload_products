module Spree
  module Admin
    class ProductFilesController < ResourceController
      def create
        uploader.add_to_queue
        flash[:success] = flash_message_for(@object, :successfully_added_to_queue)
        respond_with(@object) do |format|
          format.html { redirect_to location_after_save }
          format.js   { render layout: false }
        end
      rescue => e
        flash_message = e.respond_to?(:flash_message) ? e.flash_message :
                                                        Spree.t(:unknown_error)
        flash[:error] = flash_message_for(@object, flash_message)
        respond_with(@object) do |format|
          format.html { render action: :new }
          format.js { render layout: false }
        end
      end

      private

      def collection_url(options = {})
        spree.polymorphic_url([:admin, :products], options)
      end

      def uploader
        @uploader ||= begin
          file = (params[:product_file] || {})[:file]
          SpreeUploadProducts::Uploader.new(file: file)
        end
      end
    end
  end
end
