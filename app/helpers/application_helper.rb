module ApplicationHelper
  def set_title title
    title.present? ? "#{title} | #{t 'site'}" : t("site")
  end

  def status_post post
    if post.public_post?
      "<i title='#{t "post_statuses.public"}' class='fa fa-globe' aria-hidden='true'></i>".html_safe
    else
      "<i title='#{t "post_statuses.private"}' class='fa fa-lock' aria-hidden='true'></i>".html_safe
    end
  end

  def notification_content notification
    user_name = notification.user_name
    if notification.trackable_type == "ApplyJob"
      content = "<strong>#{user_name}</strong> #{t 'notifications.content_keys.apply_job'} <strong>#{notification.trackable.job_post.name}</strong>"
    end
    content.html_safe
  end
end
