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

  desc "Change user role to member"
  task status_to_state: :environment do
    Request.find_each do |request|
      if request.status == 'Waiting'
        request.state = 0
      elsif request.status == 'Being Helped'
        request.state = 1
      elsif request.status == 'Done'
        request.state = 2
      end
      request.save
    end
  end
end
