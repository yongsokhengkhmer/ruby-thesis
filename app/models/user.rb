class User < ApplicationRecord
  update_index("applicants#user") {self if applicant?}
  update_index("recruiters#user") {self if recruiter?}
  update_index("users#user") {self}

  EDUCATION_PARAMS = [:id, :school, :start_date, :end_date, :degree_id,
    :field_of_study, :grade, :social_activies, :description, :_destroy]
  EXPERIENCE_PARAMS = [:id, :company_name, :location, :position,
    :start_date, :end_date, :description, :_destroy]
  SKILL_PARAMS = [:id, :name, :description, :_destroy]
  DOCUMENT_PARAMS = [:id, :name, :link, :description, :_destroy]
  USER_PROFILE_PARAMS = [:id, :current_position, :gender, :birth_date]
  COMPANY_PROFILE_PARAMS = [:id, :website, :start_up_date,:description]
  USER_PARAMS = [:name, :email, :address, :phone_number, :avatar,
    :expected_salary, job_type_ids: [],
    educations_attributes: EDUCATION_PARAMS,
    experiences_attributes: EXPERIENCE_PARAMS,
    skills_attributes: SKILL_PARAMS,
    user_profile_attributes: USER_PROFILE_PARAMS,
    documents_attributes: DOCUMENT_PARAMS,
    company_profile_attributes: COMPANY_PROFILE_PARAMS]

  USER_PASSWORD_PARAMS = [:current_password, :password, :password_confirmation]

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:admin, :applicant, :recruiter]

  has_one :user_profile, dependent: :destroy, inverse_of: :user
  has_one :company_profile, dependent: :destroy

  has_many :experiences, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :apply_jobs, dependent: :destroy
  has_many :sent_notifications, class_name: UserNotification,
    foreign_key: :sender_id, dependent: :destroy
  has_many :received_notifications, class_name: UserNotification,
    foreign_key: :receiver_id, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :save_posts, dependent: :destroy
  has_many :like_posts, dependent: :destroy
  has_many :share_posts, dependent: :destroy
  # user mark interest on who
  has_many :mark_interests, class_name: MarkInterest, foreign_key: :marker_id, dependent: :destroy
  # who mark interest on user
  has_many :marked_interests, class_name: MarkInterest, foreign_key: :marked_id, dependent: :destroy
  has_many :comments, dependent: :destroy
  # who follow user
  has_many :followers, class_name: Relationship, foreign_key: :followed_id, dependent: :destroy
  # user follow who
  has_many :followeds, class_name: Relationship, foreign_key: :follower_id, dependent: :destroy
  has_many :notifications, as: :trackable, dependent: :destroy
  has_many :feedbacks, dependent: :nullify
  has_many :user_job_types, dependent: :destroy
  has_many :job_types, through: :user_job_types
  has_many :message_senders, class_name: "Message", foreign_key: :sender_id, dependent: :destroy
  has_many :message_receivers, class_name: "Message", foreign_key: :receiver_id, dependent: :destroy
  has_many :conversation_senders, class_name: "Conversation", foreign_key: :sender_id, dependent: :destroy
  has_many :conversation_receivers, class_name: "Conversation", foreign_key: :receiver_id, dependent: :destroy

  accepts_nested_attributes_for :experiences, allow_destroy: true
  accepts_nested_attributes_for :educations, allow_destroy: true
  accepts_nested_attributes_for :skills, allow_destroy: true
  accepts_nested_attributes_for :documents, allow_destroy: true
  accepts_nested_attributes_for :user_profile, reject_if: :role_recruiter
  accepts_nested_attributes_for :company_profile

  validates :name, presence: true
  validates :phone_number, presence: true
  validates :role, presence: true
  validates :job_types,  presence: true, unless: Proc.new {admin?}
  validates :expected_salary, numericality: {greater_than: 0}, if: Proc.new {applicant?}

  delegate :website, :start_up_date, :description, to: :company_profile,
    prefix: true, allow_nil: true
  delegate :current_position, :birth_date, :gender, to: :user_profile,
    prefix: true, allow_nil: true

  scope :by_ids_order, -> ids do
    if ids.any?
      where(id: ids).order "FIELD(#{User.table_name}.id, #{ids.map(&:to_i).join ', '})"
    else
      none
    end
  end

  def apply_job? job_post_id
    apply_jobs.select_by_job(job_post_id).present?
  end

  def follow other_user
    followeds.where followed_id: other_user.id
  end

  private
  def role_recruiter
    self.role == Settings.roles.recruiter
  end
end
