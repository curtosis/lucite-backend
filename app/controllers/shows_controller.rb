class ShowsController < ApplicationController
  
  # GET /shows
  # GET /shows.json
  def index
    
    @shows = working_season.shows
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shows }
    end
  end

  # GET /shows/1
  # GET /shows/1.json
  def show
    @season = working_season
    @show = working_season.shows.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @show }
    end
  end

  # GET /shows/new
  # GET /shows/new.json
  def new
    @show = Show.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @show }
    end
  end

  # GET /shows/1/edit
  def edit
    @show = working_season.shows.find(params[:id])
  end

  # POST /shows
  # POST /shows.json
  def create
    
    @show = working_season.shows.create!(params[:show])

    respond_to do |format|
      if @show.save
        format.html { redirect_to @show, notice: 'Show was successfully created.' }
        format.json { render json: @show, status: :created, location: @show }
      else
        format.html { render action: "new" }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shows/1
  # PUT /shows/1.json
  def update
    @show = working_season.shows.find(params[:id])

    respond_to do |format|
      if @show.update_attributes(params[:show])
        format.html { redirect_to @show, notice: 'Show was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shows/1
  # DELETE /shows/1.json
  def destroy
    @show = working_season.shows.find(params[:id])
    @show.destroy

    respond_to do |format|
      format.html { redirect_to shows_url }
      format.json { head :ok }
    end
  end
  
  def working_season
    Season.working(session)
  end
end
