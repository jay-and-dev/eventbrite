module EventsHelper

  def is_admin(event)
    if event.admin_id == current_user.id
      return true
    else
      return false
    end
  end

  def is_attendee(event)
    attendees = event.users
    if current_user.id == event.admin_id
      return true
    else
      if attendees.include?(current_user) 
        return true
      else
        return false
      end
    end
  end
end
