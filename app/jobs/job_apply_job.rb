class JobApplyJob < ApplicationJob
  queue_as :default

  def perform apply_job
    notification = apply_job.job_post.post.notifications.find_or_create_by notify_type:
      Settings.notifications.notify_types.apply_job

    user_notification = notification.user_notifications.create sender_id: apply_job.user_id,
      receiver_id: apply_job.job_post.post_user_id

    NotificationBroadCastService.new(
      "notification_channel_#{apply_job.job_post.post_user_id}", user_notification)
      .broadcast
  end
end
