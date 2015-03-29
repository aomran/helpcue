module UsersHelper
  def user_role(user)
    if user.owner?(@classroom)
      'Owner'
    else
      user.role(@classroom)
    end
  end
end
