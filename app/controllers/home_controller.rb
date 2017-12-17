class HomeController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def home
    
  end

  def incorrect
    @msg="Incorrect username or password. Please try again later"
      render 'home'
  end
  def signin
    username=params["username"]
    password=params["password"]
    user=UserDetail.find_by_username(username)
    if user
      if user.id == 1
        if user.password==password
          #render '/admin/home'
          session[:userid]=user.id
          session[:state]="from_signin"
          redirect_to url_for(:controller => :admin, :action => :home)
        else
          @msg="incorrect password"
          redirect_to :action=>'home'
        end
      else
        if user.password==password
          #redirect_to '/user/home'
          session[:userid]=user.id
          session[:state]="from_signin"
          redirect_to url_for(:controller => :user, :action => :home)
        else
          @msg="incorrect password"
          redirect_to :action=>'home'
        end
      end
    else
      @msg="incorrect username"
      redirect_to :action=>'home'
    end
  end

  def signup
    @list=Book.uniq.pluck(:category)
  end

  def signupaction
  	@user=UserDetail.new
  	@user.name=params["name"]
  	@user.email=params["email"]
  	@user.mobile=params["mobile"]
  	@user.username=params["username"]
  	@user.password=params["password"]
    @user_interest=UserInterest.new

    usernames=UserDetail.uniq.pluck(:username)
    if usernames.include? (params["username"])
      @msg="Try with another username"
      render 'home'
    else
    	if @user.save
        @user_interest.userid=@user.id
        @user_interest.interest=params["category"]
        if @user_interest.save
      		@msg="Signup success"
          render 'home'
        end
    	else
    		@msg="Signup failiure"
        render 'home'
    	end
    end
  end

  def signout
    session[:userid]=nil
    session[:state]=nil
    redirect_to url_for(:controller => :home, :action => :home)
  end
end
