module SpreeUploadProducts
  class EmptyFileError < StandardError
    def flash_message
      :empty_file
    end
  end

  class InvalidContentTypeError < StandardError
    def flash_message
      :invalid_content_type
    end
  end
end
