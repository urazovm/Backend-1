class SitesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    tour = Tour.find(params[:id])
    @sites = tour.sites
    if @sites
      render "index.json.jbuilder", status: :ok
        # status 200
    else 
      render json: { error: "Either the tour does not exist, or it has no sites to display." },
        status: :unprocessable_entity
          # status 422
    end
  end

  def create
    tour = Tour.find(params[:id])
    if tour && tour.user_id == current_user.id
      @site = tour.sites.create(site_params)
      render "create.json.jbuilder", status: :created
        # status 201
    else
      render json: { error: "You are not authorized to add a site to this tour." },
        status: :unauthorized
          # status 401
    end
  end

  def update
    self.find_tour_by_site
    if tour.user_id == current_user.id
      @site.update(site_params)
      render "update.json.jbuilder", status: :accepted
        # status 202
    else
      render json: { error: "You are not authorized to modify this site." },
        status: :unauthorized
          # status 401
    end
  end

  def show
    @site = Site.find(params[:id])
    if @site
      render "show.json.jbuilder", status: :ok
        # status 200
    end
  end

  def destroy
    self.find_tour_by_site
    if tour.user_id == current_user.id
      @site.destroy
      render plain: "The site has been deleted successfully.", status: :accepted
    else
      render json: { error: "You are not authorized to delete this site." },
        status: :unauthorized
          # status 401
    end
  end

  private

  def site_params
    params.permit(:title, :description, :image_file_name, :audio_file_name, :lat, :lon)
  end

  def find_tour_by_site
    @site = Site.find(params[:id])
    if @site
      tour = Tour.find_by(id: @site.tour_id)
    end
  end
end
