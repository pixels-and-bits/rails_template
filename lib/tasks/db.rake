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

end
