module EventsHelper

  def not_admin(event)
    if event.admin_id != current_user.id
      return true
    else
      return false
    end
  end

  def not_attendee(event)
    event.attendances.each do |attendance|
      if attendance.user_id != current_user.id
        return true
      end
    end
  end
end
