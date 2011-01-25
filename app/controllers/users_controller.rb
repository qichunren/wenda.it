# encoding: utf-8  
class UsersController < ApplicationController

  def index
    @users = User.paginate :page => params[:page], :per_page => 30
    @youareat = "users"
  end
  
  def search
    @users = User.search(params[:keyword])
    render :layout => false
  end
  
  def show
    @user = User.find params[:id]
    @user.views_count += 1
    @user.save
  end
  
  def signup
    if login? && current_user.crypted_password.nil?
      @user = current_user
    elsif !login?
      @user = User.new
    else
      raise "请先退出系统！"
    end
    @prev_action = "signup"
  end
  
  def edit
    @user = current_user
    @prev_action = "edit"
  end
  
  def create                      
    @user = User.new params[:user]  
    @user.name.strip!
    @user.new_password.strip!
    @user.new_password_confirmation.strip!
    if @user.save
      log_in(@user)
      # @user.save_avatar(params[:image]) if params[:image]
      redirect_to root_path
    else
      render :action => "signup"
    end
  end
  
  def update 
    @user = User.find params[:id]
    if @user.update_attributes params[:user]
        @user.save_avatar(params[:image]) if params[:image]
        session[:user_id] = @user.id
        redirect_to @user
    else
      @prev_action = params[:prev_action]
      render :action => @prev_action
    end
  end
  
  def login
    if request.post?
      validate_login
      if @errors.empty?
        log_in(@user)
        redirect_to params[:returnurl] || root_path
      else
        flash[:_username] = params[:username]
        render :action => "login"
      end
    end
  end
  
  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
  
  private
  
    def validate_login
      @errors = []
      if params[:username].blank?
        @errors << "用户名/Email不能为空"
      end
      if params[:password].blank?
        @errors << "密码不能为空"
      end
      if !params[:username].blank? && !params[:password].blank?
        @user = User.find_by_name(params[:username]) || User.find_by_email(params[:username])
        if @user.nil?
          @errors << "用户名/Email不存在"
        else
          @user = User.authenticate(@user.name, params[:password])
          if @user.nil?
            @errors << "密码不正确"
          end
        end
      end
    end
  
end