module ApplicationHelper
  def set_title title
    title.present? ? "#{title} | #{t 'site'}" : t("site")
  end

  def flash_class level
    case level
    when :notice then "alert-info"
    when :error then "alert-error"
    when :alert then "alert-warning"
    when :success then "alert-success"
    end
  end

  def status_post post
    if post.public_post?
      "<i title='#{t "post_statuses.public"}' class='fa fa-globe' aria-hidden='true'></i>".html_safe
    else
      "<i title='#{t "post_statuses.private"}' class='fa fa-lock' aria-hidden='true'></i>".html_safe
    end
  end

  def notification_content user_notification
    notification = user_notification.notification
    user_name = user_notification.sender_name
    if notification.notify_type == Settings.notifications.notify_types.apply_job
      content = "<strong>#{user_name}</strong> #{t 'notifications.notify_types.apply_job'} <strong>#{notification.trackable.job_post_name}</strong>"
    elsif notification.notify_type == Settings.notifications.notify_types.share_post
      if user_notification.receiver_id == notification.trackable_user_id
        content = "<strong>#{user_name}</strong> #{t 'notifications.notify_types.share_post'}"
      else
        content = "<strong>#{user_name}</strong> #{t 'notifications.notify_types.shared'}"
      end
    elsif notification.notify_type == Settings.notifications.notify_types.like
      content = "<strong>#{user_name}</strong> #{t 'notifications.notify_types.like'}"
    elsif notification.notify_type == Settings.notifications.notify_types.post_feed
      if notification.trackable.job_post.present?
        content = "<strong>#{user_name}</strong> #{t 'notifications.notify_types.post_job'}"
      else
        content = "<strong>#{user_name}</strong> #{t 'notifications.notify_types.post_status'}"
      end
    elsif notification.notify_type == Settings.notifications.notify_types.follow
      content = "<strong>#{user_name}</strong> #{t 'notifications.notify_types.follow'}"
    end
    content.html_safe
  end

  def notification_link user_notification
    notification = user_notification.notification
    if notification.notify_type == Settings.notifications.notify_types.apply_job
      notification.trackable.job_post
    elsif notification.notify_type == Settings.notifications.notify_types.share_post ||
      notification.notify_type == Settings.notifications.notify_types.like ||
      notification.notify_type == Settings.notifications.notify_types.post_feed
      notification.trackable.activity
    elsif notification.notify_type == Settings.notifications.notify_types.follow
      user_notification.sender
    end
  end

  def active_post_navbar fix_name, active_name
    fix_name == active_name ? "active" : nil
  end

  def render_pagination collection
    paginate collection, theme: "twitter-bootstrap-3",
      pagination_class: "pagination-sm pull-right"
  end

  def truncate_content content
    truncate content, length: Settings.truncates.content_post_length, separator: ""
  end

  def react_number number
    "(#{number})" if number > 0
  end
end
