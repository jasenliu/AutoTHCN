def send_email(to, subject, html)
  mail = MailFactory.new
  mail.to = to
  mail.from = 'DailyTest@thc.net.cn'
  mail.subject = subject
  mail.html = html
  #report_path = "D://AutoTHCN//report.html"
  #mail.attach(report_path)

  Net::SMTP.start('192.168.0.190') { |smtp|
    smtp.send_message(mail.to_s, 'DailyTest@thc.net.cn', to)
  }
end

def send_email_with_attach(to, subject, html, attach_path)
  mail = MailFactory.new
  mail.to = to
  mail.from = 'DailyTest@thc.net.cn'
  mail.subject = subject
  mail.html = html
  mail.attach(attach_path)

  Net::SMTP.start('192.168.0.190') { |smtp|
    smtp.send_message(mail.to_s, 'DailyTest@thc.net.cn', to)
  }
end
