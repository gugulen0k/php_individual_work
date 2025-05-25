module Admin
  class UsersController < Admin::BaseController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @users = User.all.order(created_at: :desc).page(params[:page])
    end

    def show
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
          format.html { redirect_to admin_users_path, notice: 'User was successfully created.' }
          format.turbo_stream { 
            flash.now[:notice] = 'User was successfully created.'
            redirect_to admin_users_path
          }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.turbo_stream { 
            flash.now[:alert] = 'Error creating user.'
            render :new, status: :unprocessable_entity 
          }
        end
      end
    end

    def edit
    end

    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end

      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
          format.turbo_stream { 
            flash.now[:notice] = 'User was successfully updated.'
            redirect_to admin_users_path
          }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.turbo_stream { 
            flash.now[:alert] = 'Error updating user.'
            render :edit, status: :unprocessable_entity 
          }
        end
      end
    end

    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_path, notice: 'User was successfully deleted.' }
        format.turbo_stream { 
          flash.now[:notice] = 'User was successfully deleted.'
          redirect_to admin_users_path
        }
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
    end
  end
end 