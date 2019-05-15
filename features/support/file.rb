def save_file_to_generate_folder(download_path, generate_path, save_time)
  generate_report_folder = generate_path + 'web14/' + CURRENT_DAY
  Find.find(download_path) do |file|
    next if File.directory?(file)
    file_name = File.basename(file, '.*')
    ext = File.extname(file)
    next if ext == '.txt'
    file_name = file_name + '_' + SAVE_TIME + ext
    generate_report_path = generate_report_folder + '/' + file_name 
    FileUtils.cp(file, generate_report_path)
    puts "#{file} -> #{generate_report_path}"
  end

  Find.find(download_path) do |file|
    next if File.directory?(file)
    FileUtils.remove_file(file)
    puts "remove file:#{file}"
  end
end
