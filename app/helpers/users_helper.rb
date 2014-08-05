module UsersHelper
  def user_role(user)
    if user == @classroom.owner
      'Owner'
    else
      user.role(@classroom)
    end
  end
end
