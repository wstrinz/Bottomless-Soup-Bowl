class BsbFeedsController < ApplicationController
  # GET /bsb_feeds
  # GET /bsb_feeds.json
  def index
    @bsb_feeds = BsbFeed.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bsb_feeds }
    end
  end

  # GET /bsb_feeds/1
  # GET /bsb_feeds/1.json
  def show
    @bsb_feed = BsbFeed.find(params[:id])
    @story = @bsb_feed.current_story
    if @story.nil?
      @bsb_feed.update_feed
      @story = @bsb_feed.current_story
    end

    @stitle = @story.title
    @surl = @story.url
    @spublished = @story.published
    if @story.content
      @scontent = @story.content.sanitize.html_safe
    elsif @story.summary
      @scontent = @story.summary.sanitize.html_safe
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bsb_feed }
    end
  end

  # GET /bsb_feeds/new
  # GET /bsb_feeds/new.json
  def new
    @bsb_feed = BsbFeed.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bsb_feed }
    end
  end

  # GET /bsb_feeds/1/edit
  def edit
    @bsb_feed = BsbFeed.find(params[:id])
  end

  # POST /bsb_feeds
  # POST /bsb_feeds.json
  def create
    @bsb_feed = BsbFeed.new(params[:bsb_feed])
    @bsb_feed.update_feed

    respond_to do |format|
      if @bsb_feed.save
        format.html { redirect_to @bsb_feed, notice: 'Bsb feed was successfully created.' }
        format.json { render json: @bsb_feed, status: :created, location: @bsb_feed }
      else
        format.html { render action: "new" }
        format.json { render json: @bsb_feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bsb_feeds/1
  # PUT /bsb_feeds/1.json
  def update
    @bsb_feed = BsbFeed.find(params[:id])

    respond_to do |format|
      if @bsb_feed.update_attributes(params[:bsb_feed])
        format.html { redirect_to @bsb_feed, notice: 'Bsb feed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bsb_feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bsb_feeds/1
  # DELETE /bsb_feeds/1.json
  def destroy
    @bsb_feed = BsbFeed.find(params[:id])
    @bsb_feed.destroy

    respond_to do |format|
      format.html { redirect_to bsb_feeds_url }
      format.json { head :no_content }
    end
  end

  def refresh
    @bsb_feed = BsbFeed.find(params[:id])
    @bsb_feed.update_feed

    respond_to do |format|
      format.html { redirect_to @bsb_feed }
      format.json { head :no_content }
    end
  end

  def refresh_all
    BsbFeed.all.each do |bfeed|
      bfeed.update_feed
    end

    respond_to do |format|
      format.html { redirect_to all_bsb_feeds_path  }
      format.json { head :no_content }
    end
  end

  def next
    @bsb_feed = BsbFeed.find(params[:id])
    @bsb_feed.next_article
    # @bsb_feed.read_index+=1
    # @bsb_feed.save

    respond_to do |format|
      format.html { redirect_to @bsb_feed  }
      format.json { head :no_content }
    end
  end

  def prev
    @bsb_feed = BsbFeed.find(params[:id])
    @bsb_feed.prev_article
    # @bsb_feed.read_index-=1
    # @bsb_feed.save

    respond_to do |format|
      format.html { redirect_to @bsb_feed  }
      format.json { head :no_content }
    end
  end

  def start
    @bsb_feed = BsbFeed.find(params[:id])
    @bsb_feed.read_index = 0
    @bsb_feed.save

    respond_to do |format|
      format.html { redirect_to @bsb_feed  }
      format.json { head :no_content }
    end
  end

  def next_all
    session[:all_index]+=1

    respond_to do |format|
      format.html { redirect_to all_bsb_feeds_path  }
      format.json { head :no_content }
    end
  end

  def prev_all
    session[:all_index] -= 1

    respond_to do |format|
      format.html { redirect_to all_bsb_feeds_path  }
      format.json { head :no_content }
    end
  end

  def start_all
    session[:all_index] = 0

    respond_to do |format|
      format.html { redirect_to all_bsb_feeds_path  }
      format.json { head :no_content }
    end
  end

  def all
    if session[:all_index].nil?
      session[:all_index] = 0
    end

    @story = Story.all.sort_by(&:published).reverse[session[:all_index]]

    # @bsb_feed.read_index-=1
    # @bsb_feed.save

    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end
end
