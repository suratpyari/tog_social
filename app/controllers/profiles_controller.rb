class ProfilesController < ApplicationController
  
  def index
    @order = params[:order] || 'created_at'
    @page = params[:page] || '1'
    @asc = params[:asc] || 'desc'   
    @profiles = Profile.active.paginate :per_page => Tog::Config["plugins.tog_social.profile.list.page.size"],
                                 :page => @page,
                                 :order => "profiles.#{@order} #{@asc}"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @profiles }
    end    
  end
  
  def show
    @profile = Profile.active.find(params[:id]) rescue nil
    if @profile.nil?
      flash[:notice] = "User doesn't exists"
      redirect_to '/'
    end
    store_location
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @profile }
    end    
  end
  
end
