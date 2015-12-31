unless File.exist?('.sekrets.key')
  new_key = puts "\n    Please type in a new sekrets key: "
  new_key = STDIN.noecho(&:gets).chomp

  file '.sekrets.key',
    new_key
end

@site_name = ask("What is the name of this website (page title)")

@repo_owner = ask("Who owns this repo on GitHub?")
