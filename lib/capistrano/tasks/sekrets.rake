namespace :deploy do

  namespace :sekrets do

    desc 'Upload .sekrets.key so the sekkrets can be read'
    task :upload_key do
      on roles(:app) do
        upload! './.sekrets.key', fetch(:release_path)
      end
    end

    before 'deploy:assets:precompile', 'sekrets:upload_key'

  end

end
