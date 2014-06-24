class MembersController < ApplicationController

  def index
    seed_val = Member.connection.quote(cookies[:rand_seed])
    Member.connection.execute("select setseed(#{seed_val})")
    @members = Member.approved.order('random()').includes(:categories).page(params[:page]).per(15)
    @categories = Category.order('name')
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

    @categories = Category.order('name')
    Member.connection.execute("select setseed(#{cookies[:rand_seed]})")
    @members = @category.members.approved.order('random()').includes(:categories).page(params[:page]).per(15)
    @page = params[:page]

    respond_to do |format|
      format.html # by_category.html.erb
      format.js { render :action => 'index' }
    end
  end

  def new
    @member = Member.new
    @member.url = 'http://'
    @categories = Category.order('name')
  end

  def create
    @member = Member.new(params[:member])

    if @member.save
      SiteMailer.member_activation(@member).deliver
      redirect_to member_confirm_path
    else
      @categories = Category.order('name')
      render :action => 'new'
    end
  end

  def edit
    @member = Member.find_by_edit_code(params[:edit_code])
    @categories = Category.order('name')

    if @member.blank?
      flash[:error] = 'Sorry, either your edit link has expired or the listing could not be found.'
      redirect_to root_path
    end
  end

  def update
    @member = Member.find(params[:id])

    if @member.update_attributes(params[:member])
      @member.update_attributes(:edit_code => nil, :edit_time => nil)
      flash[:success] = 'Your listing has been updated!'
      redirect_to root_path
    else
      @categories = Category.all(:order => 'name')
      render :action => 'edit'
    end
  end

  def activate
    member = Member.find_by_activation(params[:activation_code])
    if member
      member.update_attributes(:active => true, :activation => '')
      SiteMailer.member_activated(member).deliver
      flash[:success] = 'Listing activated!'
    else
      flash[:error] = 'A member could not be found with that activation code.'
    end
    redirect_to root_path
  end

  def generate_edit
    if request.post? and params[:email]
      member = Member.find_by_email(params[:email])

      if !member.blank?
        member.generate_edit_code
        SiteMailer.member_edit(member).deliver
        flash[:success] = 'An edit link has been generated and emailed to you.'
        redirect_to root_path
      else
        flash[:error] = "Could not find a listing with that email address."
      end
    end
  end
end
