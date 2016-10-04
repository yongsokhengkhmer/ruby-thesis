class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin? || user.recruiter? || user.applicant?
      can :manage, :all
    end
  end
end
