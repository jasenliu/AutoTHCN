def open_excel(file_path, sheet_name)
  excel = WIN32OLE::new('excel.Application')
  excel.displayalerts = false
  excel.visible = true
  excel_file = excel.workbooks.open(file_path)
  excel_sheet = excel_file.worksheets(sheet_name)
end

def close_excel
  #excel_sheet.Application.Quit
  #excel_sheet.close
  wmi = WIN32OLE.connect("winmgmts://")
  processes = wmi.ExecQuery("select * from win32_process where
   commandline like '%excel.exe\"% /automation %'")
  for process in processes do
    Process.kill( 'KILL', process.ProcessID.to_i)
  end
end

def get_excel_sheet_count(file_path)
  excel = WIN32OLE::new('excel.Application')
  excel.displayalerts = false
  excel.visible = false
  excel_file = excel.workbooks.open(file_path)
  sheet_count = excel_file.worksheets.count
  close_excel
  return sheet_count
end

def get_sheet_names(file_path)
  arr_sheet = []
  excel = WIN32OLE::new('excel.Application')
  excel.displayalerts = false
  excel.visible = false
  excel_file = excel.workbooks.open(file_path)
  sheet_count = excel_file.worksheets.count
  for i in 1..sheet_count
    sheet_name = excel.worksheets(i).name
    arr_sheet << sheet_name
  end
  close_excel
  return arr_sheet
end

def compare_common_sheet(generate_report_path, benchmark_report_path, sheet_name)
  diff_flag = false

  generate_report_sheet = open_excel(generate_report_path, sheet_name)
  generate_report_sheet.activate
  generate_row_count = generate_report_sheet.UsedRange.rows.count
  generate_column_count = generate_report_sheet.UsedRange.columns.count

  #puts "generate_row_count:" + generate_row_count.to_s
  #puts "generate_column_count:" + generate_column_count.to_s

  benchmark_report_sheet = open_excel(benchmark_report_path, sheet_name)
  benchmark_report_sheet.activate
  benchmark_row_count = benchmark_report_sheet.UsedRange.rows.count
  benchmark_columu_count = benchmark_report_sheet.UsedRange.columns.count

  #puts "stand_row_count:" + stand_row_count.to_s
  #puts "stand_columu_count:" + stand_columu_count.to_s
  base_name = File.basename(generate_report_path, '.*')
  report_name = base_name.sub(/_\d+_\d+/, '')

  if(generate_row_count != benchmark_row_count || generate_column_count != benchmark_columu_count)
    diff_flag = true
    msg = "Excel sheet #{base_name} used ranges are not equal"
  else
    1.upto(generate_row_count) do |row|
      1.upto(generate_column_count) do |column|
	tem_generate = generate_report_sheet.cells(row, column).value.to_s
	tem_benchmark = benchmark_report_sheet.cells(row, column).value.to_s
	if((tem_generate != tem_benchmark) && ((tem_generate.to_i - tem_benchmark.to_i).abs > 0.00001))
	  diff_flag = true
	  msg = "#{report_name} Cell(#{row}, #{column}) values are different: expected_value=#{tem_benchmark}, actual_value=#{tem_generate}"
	  puts msg
	  generate_report_sheet.cells(row, column).value = "Expected:#{tem_benchmark},Actual:#{tem_generate}"
	  generate_report_sheet.cells(row, column).Font.ColorIndex = 7
	  puts "update generate report"
	end
      end
    end
  end

  if(diff_flag)
    diff_name = base_name + '_' +sheet_name + '_diff'
    ext = File.extname(generate_report_path)
    diff_name = diff_name + ext
    diff_path = RESULT_REPORT_PATH + CURRENT_DAY + '/' + diff_name
    diff_path = diff_path.gsub(/\//, "\\\\") #for win7 64
    # for win7 64 create Desktop 
    # C:\Windows\System32\config\systemprofile\Desktop
    # C:\Windows\SysWOW64\config\systemprofile\Desktop
    generate_report_sheet.saveas(diff_path)
    $result_14.store(report_name, "diff")
  else
    if $result_14[report_name] == 'diff' 
      puts "#{report_name} is diff"
    else
      $result_14.store(report_name, 'same')
    end
  end
  close_excel
end
