module ApplicationHelper

  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
      when :success
        "alert-success" # Green
      when :error
        "alert-danger" # Red
      when :alert
        "alert-warning" # Yellow
      when :notice
        "alert-info" # Blue
      else
        flash_type.to_s
    end
  end

  def full_title(page_title)
    base_title = "The Coffee Kit"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def active_icon(boolean)
  	icon = boolean ? 'ok' : 'ban-circle'
  	raw "<span class='glyphicon glyphicon-#{icon}'></span>"
  end

end
