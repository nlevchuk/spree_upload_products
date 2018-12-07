module SpreeUploadProducts
  class Uploader
    attr_reader :file, :path, :content_type

    def initialize(options = {})
      @file = options[:file]
      @path = options[:path]
      @content_type = options[:content_type]
    end

    def add_to_queue
      raise EmptyFileError.new if file.nil?
      raise InvalidContentTypeError.new unless valid_content_type?
      Job.perform_later(file.tempfile.path, file.content_type)
    end

    def process
      ext = get_ext_by_content_type
      ext.new(path).parse
    end

    private

    def valid_content_type?
      CONTENT_TYPES_AND_CONSTS.keys.include?(file.content_type)
    end

    def get_ext_by_content_type
      CONTENT_TYPES_AND_CONSTS[content_type]
    end
  end
end
