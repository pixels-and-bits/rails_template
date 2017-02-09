class Attachment < ActiveRecord::Base
  belongs_to :attachable,
    polymorphic: true

  mount_uploader :attachment, AttachmentUploader

  before_create :set_meta

  def extension
    File.extname(name)
  end

  private

    def set_meta
      return unless attachment

      self.name = File.basename(attachment.to_s)
      self.filesize = attachment.file.size
    end

end
