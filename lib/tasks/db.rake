namespace :db do

  desc "Bounce the DB"
  task :bounce do
    system 'spring stop'
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke

    if File.exists?(Rails.root.join('public', 'uploads')) and 'directory' == File.ftype(Rails.root.join('public', 'uploads'))
      FileUtils.rm_rf(Rails.root.join('public', 'uploads'))
    end

    Rake::Task['db:seed'].invoke
    Rake::Task['db:test:prepare'].invoke
    system 'spring &> /dev/null && spring status'
  end

  desc "Seed the DB"
  task :seed, [:seed]  => :environment do |t, args|
    ActionMailer::Base.perform_deliveries = false

    require 'faker'
    I18n.reload!

    if seed = args[:seed]
      Dir["{db/#{seed}.rb,db/seeds/#{seed}.rb,db/seeds/#{Rails.env}/#{seed}.rb}"].each do |seed|
        require Rails.root.join(seed)
      end
    else
      Dir["{db/seeds.rb,db/seeds/*.rb}"].sort.each do |seed|
        require Rails.root.join(seed)
      end

      Dir["{db/seeds/#{Rails.env}/**.rb}"].sort.each do |seed|
        require Rails.root.join(seed)
      end
    end
  end

  desc "Backup the DB"
  task :backup => :environment do
    system %Q(PGPASSWORD="#{dbconfig.password}" pg_dump -cv -U #{dbconfig.username} -h #{dbconfig.host} #{dbconfig.database} 2> /dev/null > /ebs/backups/#{Time.now.strftime('%F_%k-%m-%S')}.#{dbconfig.database}.sql)
  end

  desc "Dump the DB"
  task :dump, [:user] => :environment do |t, args|
    dumpdir = Rails.root.join('tmp', 'db_dumps', args[:user])

    FileUtils.mkdir_p(dumpdir)

    dumpfile = "#{dumpdir}/#{Time.now.strftime('%F_%k-%m-%S')}.#{dbconfig.database}.sql"

    system %Q(PGPASSWORD="#{dbconfig.password}" pg_dump -cv -U #{dbconfig.username} -h #{dbconfig.host} #{dbconfig.database} 2> /dev/null > #{dumpfile})

    puts dumpfile
  end

end

def dbconfig
  @dbconfig ||= Map.new(
    YAML.load(
      ERB.new(
        File.read("#{Rails.root}/config/database.yml")
      ).result
    ).fetch(Rails.env)
  )
end
