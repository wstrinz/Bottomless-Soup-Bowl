class FlavorsController < ApplicationController
  @available_algorithms = [["Facebook","Fbook"],["Recentness","Time"]]
  before_filter :authenticate_user!

  # GET /flavors
  # GET /flavors.json
  def index
    @flavors = current_user.flavors.all
    @algorithms = [["Facebook","fbook"],["Timeliness","time"],["Mix","fbook_plus_time"]] #would like to not have to hardcode this

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @flavors }
    end
  end

  # GET /flavors/1
  # GET /flavors/1.json
  def show
    @flavor = Flavor.find(params[:id])

    @story = @flavor.get_story(@flavor.read_index)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @flavor }
    end
  end

  # GET /flavors/new
  # GET /flavors/new.json
  def new
    @flavor = Flavor.new
    @user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @flavor }
    end
  end

  # GET /flavors/1/edit
  def edit
    @flavor = Flavor.find(params[:id])
    @user = current_user
  end

  # POST /flavors
  # POST /flavors.json
  def create
    @flavor = Flavor.new(params[:flavor])
    @user = current_user
    incl_feeds = params["Feeds"]
    #puts params["Feeds"]
    incl_feeds.each do |t|
      fobj = BsbFeed.where("title = ?",t)
      if(fobj)
        @flavor.bsb_feeds << fobj
      end
    end
    @flavor.read_index = 0
    @flavor.user = current_user
    @flavor.sorter = Sorter.create(name: "Default", algorithm: "time")
    # if(@flavor.valid?)
    #   current_user.bsb_feeds.each do |bfeed|
    #     @flavor.bsb_feeds << bfeed
    #   end
    # end

    respond_to do |format|
      if @flavor.save
        format.html { redirect_to calculate_flavor_scores_path(@flavor) }
        format.json { render json: @flavor, status: :created, location: @flavor }
      else
        format.html { render action: "new" }
        format.json { render json: @flavor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /flavors/1
  # PUT /flavors/1.json
  def update
    @flavor = Flavor.find(params[:id])

    respond_to do |format|
      if @flavor.update_attributes(params[:flavor])
        format.html { redirect_to @flavor, notice: 'Flavor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @flavor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flavors/1
  # DELETE /flavors/1.json
  def destroy
    @flavor = Flavor.find(params[:id])
    @flavor.destroy

    respond_to do |format|
      format.html { redirect_to flavors_url }
      format.json { head :no_content }
    end
  end

  def calculate_scores
    @flavor = Flavor.find(params[:id])
    @flavor.delay.score_stories
    @flavor.read_index = 0
    @flavor.save

    respond_to do |format|
      format.html { redirect_to flavors_url }
      format.json { head :no_content }
    end
  end

  def next
    @flavor = Flavor.find(params[:id])
    if params[:keep_unread]
      @flavor.read_index+=1
    else
      current_user.mark_read(@flavor.get_story(@flavor.read_index))
    end
    @flavor.save

    respond_to do |format|
      format.html { redirect_to @flavor  }
      format.json { head :no_content }
    end
  end

  def prev
    @flavor = Flavor.find(params[:id])
    if params[:keep_unread]
      @flavor.read_index-=1
    else
      current_user.mark_read(@flavor.get_story(@flavor.read_index))
    end
    @flavor.save

    respond_to do |format|
      format.html { redirect_to @flavor  }
      format.json { head :no_content }
    end
  end

  def start
    @flavor = Flavor.find(params[:id])
    @flavor.read_index = 0
    @flavor.save

    respond_to do |format|
      format.html { redirect_to @flavor  }
      format.json { head :no_content }
    end
  end

  def set_algorithm
    @flavor = Flavor.find(params[:id])
    if params[:algorithm]
      @flavor.sorter.algorithm = params[:algorithm]
      @flavor.sorter.save
    end

    respond_to do |format|
      format.html { redirect_to flavors_path  }
      format.json { head :no_content }
    end
  end
end
