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
    uploadfile = params[:user][:importfile]
    #f = File.open(Rails.root.join('public','uploads',uploadfile.original_filename))
    urls = import_feeds_from_xml(uploadfile)

    urls.each do |u|
      if BsbFeed.new(url: u).valid?
        current_user.bsb_feeds.create!(url: u)
      end

      ## some debug code
      # #fd = Feedzirra::Feed.fetch_and_parse(u)
      # fd = u
      # if !fd || (fd.is_a? Fixnum)
      #   "err:#{u}"
      # else
      #   #fd.title
      #   u
      # end
    end
  end
end
