require 'spec_helper'

describe UploadProductsWorker do
  subject { described_class }
  let(:uploader) { SpreeUploadProducts::Uploader }

  it 'receives new method with parameters from the uploader' do
    options = { path: 'file_path', content_type: 'content_type' }
    allow(uploader).to receive(:new).with(options) { double('Uploader', process: true) }
    work = subject.new
    work.perform('file_path', 'content_type')
  end

  it 'receives process method from the uploader' do
    expect_any_instance_of(uploader).to receive(:process)
    work = subject.new
    work.perform('file_path', 'content_type')
  end
end
