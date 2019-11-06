module EventsHelper

  def is_owner(event)
      current_user.id == event.admin_id
   end
end
