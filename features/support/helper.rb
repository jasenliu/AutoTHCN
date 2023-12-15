def wait_for(seconds)
    Selenium::WebDriver::Wait.new({:timeout => seconds}).until { yield }
end

def save_compare_report_result_to_excel
  result_path = RESULT_REPORT_PATH + CURRENT_DAY + '/TestResult.xls'
  result_path = result_path.gsub(/\//, "\\\\")
  excel = open_excel(result_path)
  excel = excel.worksheets('Sheet1')
  excel.activate
  i = 1
  $result_14.each do |key, value|
    i += 1
    excel.cells(i, 1).value = key
    excel.cells(i, 2).value = value
  end
  excel.saveas(result_path)
  close_excel
end

def send_compare_report_result
  ip = Socket.ip_address_list[1].ip_address
  html = <<html_end
      <html>
        <body>
          The following is the result:
          <table border="1" cellspacing="1" cellpadding="1">
            <tr>
              <td>Report</td>
              <td>WEB14</td>
            </tr>
            <% $result_14.each do |key, value| %>
              <tr>
                <td><%= key %></td>
                  <% if value == 'same' %>
                    <td style='color:green'><%= value %></td>
                  <% else %>
                    <td style='color:red'><%= value %></td>
                  <% end %>
                </tr>
              <% end %>
            </table>
            <a href='file:///\\#{ip}\\AutoTHCN\\lib\\report\\generate_report\\web14\\<%= CURRENT_DAY %>'>click here to view generate report</a>
            <br />
            <a href='file:///\\#{ip}\\AutoTHCN\\lib\\report\\benchmark_report\\web14\\exl'>click here to view benchmark report</a>
            <br />
            <a href='file:///\\#{ip}\\AutoTHCN\\lib\\data_file\\excel_file'>click here to view benchmark file</a>
            <br />
            <a href='file:///\\#{ip}\\AutoTHCN\\lib\\test_result\\<%= CURRENT_DAY %>'>click here to view diff report</a> 
          </body>
        </html>
html_end

  erb = ERB.new(html)
  send_email('eng-thc@thchf.com.cn', 'ThcDecisions Compare finished', erb.result(binding))
end

