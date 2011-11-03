class EydMailer < ActionMailer::Base
  default :from => "tang.jilong@gmail.com"

  def mail_new_posts
    #attachments["wmd-buttons.png"] = File.read("#{Rails.root}/public/images/wmd-buttons.png")
    mail(:to => "tang.jilong <tang.jilong@139.com>", :subject => "This is my first Everyday email")
  end
end
