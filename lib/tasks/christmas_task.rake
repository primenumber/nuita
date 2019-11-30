namespace :christmas_task do
  desc 'just create a badge for advent calendar 2019 (not set to any users)'
  task create_badge: :environment do
    badge = Badge.create(
      name: 'ホワイトクリスマス',
      description: 'Nuita Advent Calendar 2019を完走する',
      icon: 'badges/christmas_2019'
    )
    p badge
  end

  desc 'recover the stamps for Advent Calendar'
  task recover_stamps: :environment do
    Stamp.destroy_all
    Nweet.where("did_at > ?", Time.zone.local(2019, 11, 30)).find_each do | nweet |
      p nweet.stamps.create(targeted_at: nweet.did_at, action: :nweet, user: nweet.user)
    end
    Like.where("created_at > ?", Time.zone.local(2019, 11, 30)).find_each do | like |
      p like.user.add_stamp_by_like(like)
    end
  end
end
