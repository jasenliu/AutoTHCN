def init_folder(root_folder)

  if !File.exist?("#{root_folder}/lib/report/generate_report//web14/#{CURRENT_DAY}")
    Dir.mkdir("#{root_folder}/lib/report/generate_report/web14/#{CURRENT_DAY}")
  end

  if !File.exist?("#{root_folder}/lib/test_result/#{CURRENT_DAY}")
    Dir.mkdir("#{root_folder}/lib/test_result/#{CURRENT_DAY}")
    FileUtils.cp("#{root_folder}/lib/test_result/TestResult.xls", "#{root_folder}/lib/test_result/#{CURRENT_DAY}/TestResult.xls")
    FileUtils.cp("#{root_folder}/lib/test_result/fico_loan.xls", "#{root_folder}/lib/test_result/#{CURRENT_DAY}/fico_loan.xls")
  end
end
