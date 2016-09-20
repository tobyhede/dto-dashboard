namespace :bootstrap do
  desc "Creates an admin user"
  task :admin_user => :environment  do
    if ENV['ADMIN_EMAIL'] && ENV['ADMIN_PASSWORD']
      user = User.new(:email => ENV['ADMIN_EMAIL'], :password => ENV['ADMIN_PASSWORD'], :password_confirmation => ENV['ADMIN_PASSWORD'])
      user.skip_confirmation!
      user.save!
    end
  end
end
