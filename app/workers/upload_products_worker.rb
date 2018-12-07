class UploadProductsWorker
  include Sidekiq::Worker

  def perform(path, content_type)
    uploader = SpreeUploadProducts::Uploader.new(path: path,
                                                 content_type: content_type)
    uploader.process
  end
end
