Dir['lib/tasks/**/*'].each do |task|

  file task,
    processed_file(task)

end
