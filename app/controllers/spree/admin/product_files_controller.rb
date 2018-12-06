module Spree
  module Admin
    class ProductFilesController < ResourceController
      def create
        flash[:success] = flash_message_for(@object, :successfully_added_to_queue)
        respond_with(@object) do |format|
          format.html { redirect_to location_after_save }
          format.js   { render layout: false }
        end
      rescue => e
        respond_with(@object) do |format|
          format.html { render action: :new }
          format.js { render layout: false }
        end
      end

      private

      def collection_url(options = {})
        spree.polymorphic_url([:admin, :products], options)
      end
    end
  end
end
