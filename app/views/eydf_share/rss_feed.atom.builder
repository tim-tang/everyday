atom_feed do |feed|
  feed.title "Everyday Newest Posts"
  feed.updated @updated

  @total_blogs.each do |blog|
    next if blog.updated_at.blank?
    feed.entry(blog, :url=> show_blog_path(blog)) do |entry|
      entry.title blog.title 
      entry.content rich_content(blog.content), :type =>'html'
      entry.url show_blog_path(blog)
      entry.updated(blog.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))
      entry.author do |author|
        author.name  blog.author
        author.email "tang.jilong@gmail.com"
      end
    end
  end
end
