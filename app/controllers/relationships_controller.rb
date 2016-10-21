class RelationshipsController < ApplicationController
  load_and_authorize_resource

  def create
    @relationship = current_user.followeds.new relationship_params
    flash.now[:alert] = t("flashes.relationships.create.fail") unless @relationship.save

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @relationship.destroy

    respond_to do |format|
      format.js
    end
  end

  private
  def relationship_params
    params.require(:relationship).permit Relationship::RELATIONSHIP_PARAMS
  end
end
