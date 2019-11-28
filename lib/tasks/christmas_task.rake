namespace :christmas_task do
  desc 'just create a badge for advent calendar 2019 (not set to any users)'
  task create_badge: :environment do
    badge = Badge.create(
      name: 'ホワイトクリスマス',
      description: 'Nuita Advent Calendar 2019を完走する',
      icon: 'christmas/logo_ac'
    )
    p badge
  end
end
