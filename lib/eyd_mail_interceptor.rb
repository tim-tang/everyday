class EydMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    # Be sure to change the email to your own when enabling this
    message.to = "tang.jilong@139.com"
  end
end
