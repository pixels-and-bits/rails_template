%w(
  lib/tasks/db.rake
).each do |task|

  file task,
    processed_file(task)

end
