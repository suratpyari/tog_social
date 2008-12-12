class Admin::GroupsController < Admin::BaseController
  before_filter :neglect_group
  def index
    @order = params[:order] || 'name'
    @page = params[:page] || '1'
    @groups = Group.paginate :per_page => 20,
                             :page => @page,
                             :order => "#{@order} ASC"
  end

  def edit
    @group = Group.find(params[:id])
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    respond_to do |wants|
      wants.html do
        flash[:ok]='Group deleted.'
        redirect_to admin_groups_path
      end
    end
  end

  def activate
    @group = Group.find(params[:id])
    @group.activate!
    respond_to do |wants|
      if @group.activate!
        wants.html do
          render :text => "<span>Group is now active</span>"
        end
      end
    end
  end
  
  private ########################
  
    
    def neglect_group
      flash[:error] = "Page not found"
      redirect_to '/'
    end

end
