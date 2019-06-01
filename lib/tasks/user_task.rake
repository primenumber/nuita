namespace :user_task do
  desc "Set random url-digest to existing users"

  task :set_url_digest => :environment do
    User.all.each do |user|
      if user.url_digest.nil?
        user.url_digest = SecureRandom.alphanumeric
        user.save
      end
    end
  end
end
