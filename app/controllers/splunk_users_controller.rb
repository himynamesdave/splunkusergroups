class SplunkUsersController < ApplicationController
  before_filter :add_user
  before_filter :add_collections, only: [:new, :create]

  def index
  end

  def validate_key
    @code = params[:code]
    if !@code.blank? and group = @user.get_user_group(@code)
      redirect_to new_splunk_user_path(code: @code)
    else
      flash.now[:notice] = "Oops, this event ID appears to be incorrect." 
      render 'index'
    end
  end

  def new
  end

  def create
    @user.assign_attributes(user_attributes)
    if @user.valid?
      @user.splunk_save
      render "completed"
    else 
      puts @user.errors.inspect
      render "new"
    end
  end
  

  private

    def add_user
      @user = SplunkUser.new
    end

    def add_collections
      @code = params[:code]
      if @code.blank? or !(@group = @user.get_user_group(@code))
        return redirect_to root_path, notice: "Oops, this event ID appears to be incorrect." 
      end
      @meetup_url = @group["addUserGroupMeetupPage"]
      @city = @group["addUserGroupCity"]
      @use_cases = @user.use_cases
      @products = @user.products
      @roles = @user.job_roles
    end

    def user_attributes
      params.require(:splunk_user).permit(:name, :email, :notes, :role, :splunk_products => [], :splunk_use_cases => []).merge({city: @city})
    end
end
