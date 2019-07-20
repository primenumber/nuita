namespace :nweet_task do
  desc "Set random url-digest to existing nweets"

  task :set_url_digest => :environment do
    Nweet.all.each do |nweet|
      if nweet.url_digest.nil?
        nweet.url_digest = SecureRandom.alphanumeric
        nweet.save
      end
    end
  end

  task :refresh_link => :environment do
    Nweet.all.each do |nweet|
      nweet.create_link
    end
  end
end
