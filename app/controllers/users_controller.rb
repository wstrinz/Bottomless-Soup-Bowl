class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @bsb_feeds = @user.bsb_feeds

    if(current_user != @user)
      respond_to do |format|
        format.html { redirect_to users_path, notice: "Not allowed to view other user's feeds" }
        format.json { head :no_content }
      end
    end
  end

  def import_feeds
    @user = current_user
  end

  def do_feed_import

    if params[:user]
      uploadfile = params[:user][:importfile]
      #f = File.open(Rails.root.join('public','uploads',uploadfile.original_filename))
      current_user.import_feeds(uploadfile)
    end

    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end

  def remove_all_feeds
    current_user.remove_all_feeds
    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end

  def feeds
    @user = User.find(params[:id])
    @bsb_feeds = @user.bsb_feeds

    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end

  def show_current
    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end

  def refresh
    current_user.refresh_stats

    respond_to do |format|
      format.html {redirect_to current_user}
      format.json { head :no_content }
    end
  end
end
