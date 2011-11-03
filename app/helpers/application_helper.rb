module ApplicationHelper
  def parse_coderay(text)
    text.scan(/(\[code\:([a-z].+?)\](.+?)\[\/code\])/m).each do |match|  
      text.gsub!(match[0],CodeRay.scan(match[2].strip, match[1].to_sym).div(:css => :class))  
    end  
    return text
  end

  def avatar_url(comment)
    if comment.email.present?
    gravatar_id = Digest::MD5.hexdigest(comment.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
    else
      "http://www.everyday-cn.com/images/avatar.png"
    end
  end

  def cached_tags(blog)
    @tag_list= Rails.cache.read("#{blog.id}_tag")
     if !@tag_list
     @tag_list= blog.tag_list
       Rails.cache.write("#{blog.id}_tag",@tag_list)
     end
     @tag_list
  end

  def cached_comments(blog)
    @comment_count= Rails.cache.read("#{blog.id}_comments")
     if !@comment_count
       @comment_count = EydComment.count_by_sql("select count(0) from eyd_comments comment where comment.blog_id = #{blog.id}")
       Rails.cache.write("#{blog.id}_comments",@comment_count)
     end
     @comment_count
  end
  
  def cached_categories(blog)
    @category= Rails.cache.read("#{blog.id}_categories")
     if !@category
       @category = EydConstant.find_by_sql("select cate.* from eyd_constants cate where cate.id = #{blog.constant_id}")
       Rails.cache.write("#{blog.id}_categories",@category)
     end
     @category[0]
  end
end
