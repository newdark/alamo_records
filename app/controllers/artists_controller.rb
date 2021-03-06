# frozen_string_literal: true

class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[show edit update destroy]
  before_action :set_artists, only: :index

  respond_to :html

  def index
    respond_with(@artists) do |format|
      # you don't really need this code if you follow the serializer structure.
      # however if you don't you can always define your own custom serilizer which might
      # be something that is required.
      format.csv { render csv: @artists, serializer: Csv::ArtistSerializer }
    end
  end

  def show
    respond_with(@artist)
  end

  def new
    @artist = Artist.new
    respond_with(@artist)
  end

  def edit; end

  def create
    @artist = Artist.new(artist_params)
    @artist.save
    respond_with(@artist)
  end

  def update
    @artist.update(artist_params)
    respond_with(@artist)
  end

  def destroy
    @artist.destroy
    respond_with(@artist)
  end

  private

  def set_artist
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit(:name)
  end

  # TODO: this needs to be split into a service... it is going to be super big
  def set_artists # rubocop:disable AbcSize
    # term = params[:search][:term] if params[:search]
    @artists = Artist.all.includes(:records)
    @artists = @artists.page(params[:page])
    @artists = if params[:order]
                 @artists.order(params[:order][:column] => params[:order][:direction])
               else
                 @artists.order(name: :desc)
               end
  end
end
