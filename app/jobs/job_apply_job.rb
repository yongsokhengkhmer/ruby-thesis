class JobApplyJob < ApplicationJob
  queue_as :default

  def perform apply_job
    notification = apply_job.create_notification(
      content_key: Settings.notifications.content_keys.apply_job,
      user_id: apply_job.user.id)

    notification.user_notifications.create user_id: apply_job.job_post.post_user_id

    NotificationBroadCastService.new(
      "notification_channel_#{apply_job.job_post.post_user_id}", notification)
      .broadcast
  end
end
