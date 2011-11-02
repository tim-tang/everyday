begin
  require 'deadweight'
rescue LoadError
end

desc "run Deadweight CSS check (requires script/server)"
task :deadweight do
  dw = Deadweight.new
  #dw.stylesheets = ["/stylesheets/templatemo_style.css","/stylesheets/flickr_pagination.css","/stylesheets/wmd.css","/stylesheets/coderay.css","/stylesheets/galleriffic-2.css","/stylesheets/white/style.css"]
  dw.stylesheets = ["/stylesheets/templatemo_style.css"]
  #dw.stylesheets = ["/stylesheets/flickr_pagination.css"]
  #dw.stylesheets = ["/stylesheets/wmd.css"]
  #dw.stylesheets = ["/stylesheets/coderay.css"]
  #dw.stylesheets = ["/stylesheets/galleriffic-2.css"]
  dw.pages = ["/", "/tech_list","/gallery_list","/ibook_list","/guest_book","/show_blog/rails-fragment","/tag_ibook_list/asdf","/category_list/5","/archival_list/2011-10","/tag_list/RubyOnRails"]
  #dw.ignore_selectors = /flash_notice|flash_error|errorExplanation|fieldWithErrors/
  puts dw.run
end
