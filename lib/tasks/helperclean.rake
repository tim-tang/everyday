desc "Clear unused helpers"
task :helperclean do 
  Dir.glob("app/helpers/**/*.rb").each do |file|
    if !File.read(file).index('def')
      FileUtils.rm file
      FileUtils.rm_f file.sub("app/", "test/unit/").sub(".rb", "_test.rb") if File.exists?("test")
      FileUtils.rm_f file.sub("app/", "spec/").sub(".rb", "_spec.rb") if File.exist?("spec")
    end
  end
end
