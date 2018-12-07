require 'spec_helper'

module SpreeUploadProducts
  class TestExt
    def initialize(path)
    end

    def parse
    end
  end

  describe Uploader do
    let(:file_path) { Rails.root + '../../spec/support/sample.csv' }
    let(:content_type) { 'text/csv' }

    context '#add_to_queue' do
      it 'raises an error if file is empty' do
        subject = described_class.new
        expect { subject.add_to_queue }.to raise_error(EmptyFileError)
      end

      it 'raises an error if content type is not supported' do
        file = fixture_file_upload(file_path, 'text/not_supported')
        subject = described_class.new(file: file)
        expect { subject.add_to_queue }.to raise_error(InvalidContentTypeError)
      end

      it 'receives perform_later method with parameters from the job wrapper' do
        file = fixture_file_upload(file_path, content_type)
        subject = described_class.new(file: file)

        expect(Job).to receive(:perform_later).with(file.tempfile.path, content_type)
        subject.add_to_queue
      end
    end

    context '#process' do
      subject do
        described_class.new(path: file_path, content_type: content_type)
      end

      before do
        allow(subject).to receive(:get_ext_by_content_type) { TestExt }
      end

      it 'receives new method with parameter from the extension' do
        expect(TestExt).to receive(:new).with(file_path) { double('TestExt', parse: true) }
        subject.process
      end

      it 'receives parse method from the extension' do
        expect_any_instance_of(TestExt).to receive(:parse)
        subject.process
      end
    end
  end

end
