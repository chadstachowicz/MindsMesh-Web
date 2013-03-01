class PostAttachment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :link_url, :subtype, :image, :file

  PAPERCLIP_PATH = "/system/:rails_env/:class/:attachment/:id_partition/:style/:filename"
  PAPERCLIP_OPTIONS = {path: ":rails_root/public#{PAPERCLIP_PATH}", url:  PAPERCLIP_PATH, styles: {thumb: "100x100#"}}

  has_attached_file :file,  PAPERCLIP_OPTIONS


  validates_presence_of :subtype
  validates_attachment :file, size: { less_than: 50.megabytes }
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


  #
  def ext_path
    accepted_exts = %w(_page _blank aac css dotx exe hpp java mp3 ods ott png qt sql txt xml aiff bmp dat dwg flv html jpg mp4 odt ppt rar tga wav yml ai c dmg dxf gif ics key mpg otp pdf psd rb tgz xls zip avi cpp doc eps h iso mid odf ots php py rtf tiff xlsx)
    ext = file.original_filename.split('.').last
    ext = accepted_exts.first unless accepted_exts.include? ext
    "/images/file_types/32px/#{ext}.png"
  end

end
