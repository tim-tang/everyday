module ApplicationHelper
  def parse_coderay(text)
    text.scan(/(\[code\:([a-z].+?)\](.+?)\[\/code\])/m).each do |match|  
      text.gsub!(match[0],CodeRay.scan(match[2].strip, match[1].to_sym).div(:css => :class))  
    end  
    return text
  end
end
