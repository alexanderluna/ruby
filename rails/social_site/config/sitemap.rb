# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.oremosadios.com"
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-us-west-2.amazonaws.com/hyouka/"
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new

SitemapGenerator::Sitemap.create do
  add '/feed', :changefreq => 'always'
  add '/resource', :changefreq => 'weekly'

  Micropost.find_each do |micropost|
    unless micropost.title?
      content = micropost.content.split(/[\s,';.]/)
      title = ""
      title << content[0..7].join(" ")
      micropost.title = title
    end

    add "/microposts/#{micropost.id}/#{micropost.title.split(" ").join("-")}", :lastmod => micropost.updated_at
  end
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
