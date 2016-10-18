class MarkInterestsController < ApplicationController
  load_and_authorize_resource

  def create
    @mark_interest = current_user.mark_interests.new mark_interest_params

    flash.now[:alert] = t("flashes.mark_interests.create.fail") unless @mark_interest.save

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @mark_interest.destroy

    respond_to do |format|
      format.js
    end
  end

  private
  def mark_interest_params
    params.require(:mark_interest).permit MarkInterest::MARK_INTERTEST_PARAMS
  end
end
