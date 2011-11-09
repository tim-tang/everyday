desc 'Custom curise task for RSpec'
task :cruise do
  ENV['RAILS_ENV'] = 'test'

  if File.exists?(Dir.pwd + "/config/database.yml")
    if Dir[Dir.pwd + "/db/migrate/*.rb"].empty?
      raise "No migration scripts found in db/migrate/ but database.yml exists, " +
        "CruiseControl won't be able to build the latest test database. Build aborted."
    end

    if Rake.application.lookup('db:migrate')
      Rake::Task['db:migrate'].invoke
    end
  end

  Rake::Task['spec:rcov'].invoke
  #CruiseControl::invoke_rake_task 'spec:rcov'

  if Rake.application.lookup('db:test:purge')
    Rake::Task['db:test:purge'].invoke
  end
end
