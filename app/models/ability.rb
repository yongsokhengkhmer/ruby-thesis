class Ability
  include CanCan::Ability

  def initialize user, controller_namespace
    user ||= User.new
    can :manage, :all
    if controller_namespace == "Admin" && (user.recruiter? || user.applicant?)
      cannot :manage, :all
    end

    if user.applicant?
      cannot :manage, JobPost
    elsif user.recruiter?
      cannot :manage, ApplyJob
    end
  end
end
