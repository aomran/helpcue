namespace :helpcue do
  desc "Update gravatars of existing Users"
  task update_gravatars: :environment do
    User.all.find_each do |user|
      user.save
    end
  end

  desc "Change user role to member"
  task user_to_member: :environment do
    ClassroomUser.where(role: 'User').find_each do |cu|
      cu.role = 'Member'
      cu.save
    end
  end
end