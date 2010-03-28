class MembersController < ApplicationController
  
  def index
    @members = Member.approved.paginate(:all, :per_page => 15, :page => params[:page], :include => :categories)
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
