class AttachmentUploader < CarrierWave::Uploader::Base

    include CarrierWave::MiniMagick
    include CarrierWave::MimeTypes

    process :auto_orient

    def store_dir
      "uploads/#{mounted_as}/#{model.id}"
    end

    def auto_orient
      return file unless image?(file)

      manipulate! do |img|
        img.auto_orient
      end
    end

    version :thumb, :if => :image? do
      process :resize_to_fill => [200,200]
    end

    version :mini, :from_version => :thumb, :if => :image? do
      process :resize_to_fill => [50,50]
    end

    protected

      def image?(file)
        %w(jpg jpeg gif png bmp).include?(file.extension.downcase.strip)
      end

end
