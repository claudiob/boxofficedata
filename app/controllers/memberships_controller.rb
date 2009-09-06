class MembershipsController < ApplicationController
  # GET /memberships
  # GET /memberships.xml
  def index
    conditions = {}
    conditions = conditions.merge(:group_id => params[:group_id]) unless params[:group_id].blank?
    @memberships = Membership.paginate(:include => [:item, :group],
    :conditions => conditions, :page => params[:page], :per_page  => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @memberships }
    end
  end

end
