namespace :category_task do
  desc "initialize categories"
  task init: :environment do
    Preference.destroy_all
    Category.destroy_all

    Category.create(name: 'R18G', description: '猟奇的・残酷な描写')
    Category.create(name: '3D', description: '撮影された動画や画像')

    Category.where(censored_by_default: true).each do |category|
      puts "censoring #{category.name}..."
      User.find_each do |user|
        print "#{user.id} "
        user.censored_categories << category
      end
      puts ""
    end
  end

  desc "remove unnecessary(not censored by default) categories"
  task clean: :environment do
    Category.where(censored_by_default: false).destroy_all
  end
end
