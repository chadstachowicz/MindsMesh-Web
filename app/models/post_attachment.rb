class PostAttachment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :link_url, :subtype, :image, :file

  PAPERCLIP_PATH = "/system/:rails_env/:class/:attachment/:id_partition/:style/:filename"
  PAPERCLIP_OPTIONS = {path: ":rails_root/public#{PAPERCLIP_PATH}", url:  PAPERCLIP_PATH, styles: {thumb: "100x100#"}}

  has_attached_file :file,  PAPERCLIP_OPTIONS


  validates_presence_of :subtype
  validates_attachment :file, size: { less_than: 10.megabytes }
  validate :validate_not_executable

  def validate_not_executable
    if file && %w(exe msi).include?(file.original_filename.split('.').last)
      errors[:file] << "format *.#{file.original_filename.split('.').last} is not acceptable"
    end
  end

  before_post_process :skip_unless_image

  def skip_unless_image
    file.content_type.include? 'image'
  end

  def self.my_create_file!(post, file)
    subtype = file.content_type.include?('image') ? 'image' : 'file'
    post.post_attachments.create!(subtype: subtype, file: file)
  end
end
