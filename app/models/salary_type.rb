class SalaryType < ApplicationRecord
  SALARY_TYPE_PARAMS = [:name, :min_salary, :max_salary]

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validate :salary_validate
  validates :min_salary, numericality: {greater_than: 0, allow_nil: true}
  validates :max_salary, numericality: {greater_than: :min_salary, allow_nil: true},
    if: Proc.new {min_salary.present?}

  private
  def salary_validate
    if min_salary.blank? && max_salary.blank?
      errors.add :base, I18n.t("admin.salary_types.errors")
    end
  end
end
