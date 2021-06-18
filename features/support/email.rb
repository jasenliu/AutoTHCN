def send_email(to, subject, html)
  mail = MailFactory.new
  mail.to = to
  mail.from = 'jsliu@thc.net.cn'
  mail.subject = subject
  mail.html = html
  #report_path = "D://AutoTHCN//report.html"
  #mail.attach(report_path)

  Net::SMTP.start('smtp.exmail.qq.com', 25, 'smtp.exmail.qq.com', 'jsliu@thc.net.cn', '2018*Dm') { |smtp|
    smtp.send_message(mail.to_s, 'jsliu@thc.net.cn', to)
  }
end

def send_email_with_attach(to, subject, html, attach_path)
  mail = MailFactory.new
  mail.to = to
  mail.from = 'jsliu@thc.net.cn'
  mail.subject = subject
  mail.html = html
  mail.attach(attach_path)

  Net::SMTP.start('smtp.exmail.qq.com', 25, 'smtp.exmail.qq.com', 'jsliu@thc.net.cn', '2018*Dm') { |smtp|
    smtp.send_message(mail.to_s, 'jsliu@thc.net.cn', to)
  }
end
