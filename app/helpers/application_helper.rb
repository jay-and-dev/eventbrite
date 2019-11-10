module ApplicationHelper
  def true_admin?
    if current_user.is_admin == true
      return true
    end
  end
end
