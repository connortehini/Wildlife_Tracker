class SightingsController < ApplicationController
  def index
    if params[:start_date].blank? && params[:end_date].blank?
      @sightings = Sighting.all
    else 
      start_date,end_date = params[:start_date].to_date, params[:end_date].to_date
      
      @sightings = Sighting.where(created_at: start_date...end_date).where(region_id: params[:region_id])
    end
  end

  def show 
    @sighting = Sighting.find(params[:id])
  end 

  def new 
    @sighting = Sighting.new
  end 

  def create 
    @sighting = Sighting.new(sighting_params)
  
    if @sighting.save
      redirect_to @sighting
    else 
      render :new 
    end 
  end
  
  def edit 
    @sighting = Sighting.find(params[:id])
  end 

  def update 
    @sighting = Sighting.find(params[:id])

    if @sighting.update(sighting_params)
      redirect_to @sighting
    else 
      render :new 
    end 
  end 

  def destroy 
    @sighting = Sighting.find(params[:id])
    @sighting.destroy

    redirect_to sightings_path
  end 

  private
    def sighting_params
      params.require(:sighting).permit(:latitude, :longitude, :animal_id, :region_id, :created_at)
    end 
end 