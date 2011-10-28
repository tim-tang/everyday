module EydfHomeHelper
  def rich_content(content)
   # sanitize Redcarpet.new(content, :hard_wrap, :autolink, :no_intraemphasis).to_html
   sanitize Redcarpet.new(content,:hard_wrap, :autolink, :no_intraemphasis).to_html
  end
end
