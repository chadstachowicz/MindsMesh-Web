if Settings.env['s3']
  Paperclip::Attachment.default_options.merge!({
    :storage => :s3,
    :bucket => 'mindsmesh.com',
    :s3_credentials => Settings.env['s3']
  })
end