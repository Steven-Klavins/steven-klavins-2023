Rails.application.config.after_initialize do
    require "active_storage/service/s3_service"
  
    module SimpleCDNUrlReplacement
      CDN_HOST = "cdn.stevenklavins.co.uk"
    
      def url(...)
        url = super
        original_host = "#{ENV["SPACES_BUCKET_NAME"]}.#{ENV["SPACES_ENDPOINT"]}"      
        url.gsub(original_host, CDN_HOST)
      end
    end
  
    ActiveStorage::Service::S3Service.prepend(SimpleCDNUrlReplacement)
  end