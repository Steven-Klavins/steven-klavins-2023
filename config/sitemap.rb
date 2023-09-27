# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://stevenklavins.co.uk/"
SitemapGenerator::Sitemap.ping_search_engines

SitemapGenerator::Sitemap.create do

  add blogs_path, :changefreq => 'weekly'
  add contact_path, :changefreq => 'weekly'
  add about_path, :changefreq => 'weekly'

  # Only add published blogs to the sitemap.
  Blog.all.where(draft: false ).each do |blog|
    add(blog_path(blog),
        :lastmod => blog.updated_at,
        :changefreq => 'weekly',
        :priority => 0.9
    )
  end
end
