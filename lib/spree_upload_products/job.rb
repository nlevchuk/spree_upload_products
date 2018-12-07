module SpreeUploadProducts
  # The class is a wrapper for real background job backend
  # like Sidekiq, DJ or any you want
  # You can even call ActiveJob.perform_later without specifying backend
  class Job
    def self.perform_later(file_path, content_type)
      UploadProductsWorker.perform_async(file_path, content_type)
    end
  end
end
