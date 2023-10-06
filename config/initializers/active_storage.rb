Rails.application.configure do
  # Allow Webp to be displayed inline:
  config.active_storage.content_types_allowed_inline << "image/webp"
end