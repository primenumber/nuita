namespace :icon_task do
  desc "resize all usericons"
  task resize_all: :environment do
    User.find_each do |user|
      begin
        print "#{user.id} "
        user.icon.recreate_versions! if user.icon.present?
      rescue
        p "#{user.id} recreation failed."
      end
    end
    puts 'recreation done.'
  end
end
