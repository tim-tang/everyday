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
end
