require 'spec_helper'

module SpreeUploadProducts

  describe Job do
    subject { described_class }

    it 'creates async job' do
      expect(UploadProductsWorker.jobs.size).to eq(0)
      subject.perform_later('file_path', 'content_type')
      expect(UploadProductsWorker.jobs.size).to eq(1)
    end
  end

end
