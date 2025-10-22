module Admin
  class AdminController < ApplicationController
    before_action :require_authenticated_user
    before_action :require_admin

    def index
      @users_count = User.count
      @normal_users_count = User.normal.count
      @premium_users_count = User.premium.count
      @admin_users_count = User.admin.count
      @notes_count = Note.count
      @timers_count = Timer.count
      @study_materials_count = StudyMaterial.count
      @flashcard_collections_count = FlashcardCollection.count
    end

    def users
      @users = User.all.order(created_at: :desc)
    end

    def update_user_role
      @user = User.find(params[:id])
      if @user.update(role: params[:role])
        redirect_to admin_users_path, notice: "User role updated successfully."
      else
        redirect_to admin_users_path, alert: "Failed to update user role."
      end
    end

    def delete_user
      @user = User.find(params[:id])
      if @user.admin?
        redirect_to admin_users_path, alert: "Cannot delete admin user."
      else
        @user.destroy
        redirect_to admin_users_path, notice: "User deleted successfully."
      end
    end

    def force_logout_user
      @user = User.find(params[:id])
      if @user.admin?
        redirect_to admin_users_path, alert: "Cannot force logout admin user."
      else
        # Disable persistent session
        @user.disable_persistent_session!
        
        # Expire all remember me tokens
        @user.forget_me!
        
        # Clear remember created at (forces re-login)
        @user.update(remember_created_at: nil)
        
        redirect_to admin_users_path, notice: "User session terminated. User will need to login again."
      end
    end
  end
end
