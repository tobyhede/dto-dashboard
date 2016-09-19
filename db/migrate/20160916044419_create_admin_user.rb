class CreateAdminUser < ActiveRecord::Migration[5.0]
  def up
    if ENV['ADMIN_EMAIL'] && ENV['ADMIN_PASSWORD']
      user = User.new(:email => ENV['ADMIN_EMAIL'], :password => ENV['ADMIN_PASSWORD'], :password_confirmation => ENV['ADMIN_PASSWORD'])
      user.skip_confirmation!
      user.save!
    end
  end

  def down
    if ENV['ADMIN_EMAIL'] && ENV['ADMIN_PASSWORD']
      User.find_by(:email => ENV['ADMIN_EMAIL']).delete
    end
  end
end
