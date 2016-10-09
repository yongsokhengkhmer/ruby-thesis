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

  def notification_content notification
    user_name = notification.user_name
    if notification.trackable_type == "ApplyJob"
      content = "<strong>#{user_name}</strong> #{t 'notifications.content_keys.apply_job'} <strong>#{notification.trackable.job_post.name}</strong>"
    end
    content.html_safe
  end

  def notification_link notification
    if notification.trackable_type == "ApplyJob"
      notification.trackable.job_post
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
end
