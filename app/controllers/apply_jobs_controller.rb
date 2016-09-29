class ApplyJobsController < ApplicationController
  def new
    @job_post = JobPost.find params[:job_post_id]
    @apply_job = ApplyJob.new
  end

  def create
    @apply_job = current_user.apply_jobs.new apply_job_params
    @apply_job.save
    @job_post_id = @apply_job.job_post_id

    respond_to do |format|
      format.js
    end
  end

  private
  def apply_job_params
    params.require(:apply_job).permit ApplyJob::PARAMS_APPLY_JOB
  end
end
