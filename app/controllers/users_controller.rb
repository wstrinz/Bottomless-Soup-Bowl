class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @bsb_feeds = @user.bsb_feeds
  end

  def import_feeds
    @user = current_user
  end

  def do_feed_import
    if params[:user]
      uploadfile = params[:user][:importfile]
      #f = File.open(Rails.root.join('public','uploads',uploadfile.original_filename))
      urls = import_feeds_from_xml(uploadfile)

      urls.each do |u|
        bf = BsbFeed.new(url: u)
        if bf.valid?
          current_user.bsb_feeds.build(url: u)
        end
      end

      current_user.bsb_feeds.each do |bf|
        bf.update_feed
      end
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
end
