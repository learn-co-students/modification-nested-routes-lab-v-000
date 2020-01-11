class ArtistsController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy] do
    find_artist(params[:id]) # Note: This method is in the ApplicationController.
  end

  before_action -> { set_artist }, only: [:new, :create]

  def index
    @artists = Artist.all
  end

  def show
  end

  def new
  end

  def create
    save_artist and return # If I put "and return" inside of the helper, I think it returns BACK to this point.
    render :new
  end

  def edit
  end

  def update
    @artist.update(artist_params)
    save_artist and return
    
    render :edit
  end

  def destroy
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

  private

    def artist_params
      params.require(:artist).permit(:name)
    end

    def set_artist
      if params[:artist]
        @artist = Artist.new(artist_params)
      else
        @artist = Artist.new
      end
    end

    def save_artist
      if @artist.save
        redirect_to @artist
      end

      # else
        # @artist = Artist.find(params[:id]) 
        # This allows the artist to have its original values when the :edit page is re-rendered.
        # But do I want that? It may not be conventional.
        # If they only make a mistake with ONE field, it would be a pain for them to re-edit other fields.
    end
end

# --- Old code from create and update actions: ---
  # if @artist.save
    # redirect_to @artist
  # else
    # render :new
  # end
# --- End of old code ---