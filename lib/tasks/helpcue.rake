namespace :helpcue do
  desc "Update gravatars of existing Users"
  task update_gravatars: :environment do
    User.all.find_each do |user|
      user.save
    end
  end
end