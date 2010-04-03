class MembersController < ApplicationController
  
  def index
    @members = Member.approved.paginate(:all, :per_page => 15, :page => params[:page], :include => :categories)
    @categories = Category.all(:order => 'name')
    @page = params[:page]
  end
  
  def by_category
    if params[:slug] == 'all'
      redirect_to root_path and return
    end
    
    @category = Category.find_by_slug(params[:slug])
    if @category.blank?
      flash[:error] = 'The selected category does not exist.'
      redirect_to root_path and return
    end
    
    @categories = Category.all(:order => 'name')
    @members = @category.members.approved.paginate(:all, :per_page => 15, :page => params[:page], :include => :categories)
    @page = params[:page]
    
    respond_to do |format|
      format.html # by_category.html.erb
      format.js { render :action => 'index' }
    end
  end

  def new
    @member = Member.new
    @member.url = 'http://'
    @categories = Category.all(:order => 'name')
  end
  
  def create
    @member = Member.new(params[:member])
    
    if @member.save
      SiteMailer.deliver_member_activation(@member)
      redirect_to member_confirm_path
    else
      @categories = Category.all(:order => 'name')
      render :action => 'new'
    end
  end
  
  def activate
    member = Member.find_by_activation(params[:activation_code])
    if member
      member.update_attributes(:active => true, :activation => '')
      flash[:success] = 'Listing activated!'
    else
      flash[:error] = 'A member could not be found with that activation code.'
    end  
    redirect_to root_path
  end
end
