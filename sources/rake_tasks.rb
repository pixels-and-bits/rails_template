%w(db).each do |task|

  file "lib/tasks/#{task}",
    processed_file("lib/tasks/#{task}.rake")

end
