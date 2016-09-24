module ApplicationHelper
  def status_post post
    if post.public_post?
      "<i title='#{t "post_statuses.public"}' class='fa fa-globe' aria-hidden='true'></i>".html_safe
    else
      "<i title='#{t "post_statuses.private"}' class='fa fa-lock' aria-hidden='true'></i>".html_safe
    end
  end
end
