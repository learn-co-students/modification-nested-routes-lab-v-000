# require 'pry'

# Note: find_artist is defined in the ApplicationController.
# Remember to limit the SQL queries as much as possible.

class SongsController < ApplicationController
  before_action -> { find_song }, only: [:update, :destroy]

  def index
    if params[:artist_id]
      check_for_nil_artist and return

      @songs = @artist.songs
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      check_for_nil_artist and return
      
      @song = @artist.songs.find_by(id: params[:id])
      check_for_nil_artist_song
    else
      find_song
    end
  end

  def new
    if params[:artist_id] && !Artist.exists?(params[:artist_id])
      # I would move this into #check_for_nil_artist, but that would create an unnecessary @artist here.
      redirect_to artists_path, alert: "Artist not found"
    else
      @song = Song.new(artist_id: params[:artist_id])
      @artist = @song.artist
      # Remember that if params[:artist_id] is nil, then @song.artist_id will be nil anyway,
      # just as though I had called Song.new() instead.
      # By the same token, @artist can be nil as well.
    end
  end

  def create
    @song = Song.new(song_params)
    save_song and return # "and return" prevents the code below from executing, if the song doesn't save.
    render :new
  end

  def edit
    if params[:artist_id]
      check_for_nil_artist and return
      
      @song = @artist.songs.find_by_id(params[:id])

      # Since the redirect below is the last line of code in this part of the conditional,
      # I don't think I need "and return"
      check_for_nil_artist_song
    else 
      find_song
      # Ideally, I would redirect to /songs if the song doesn't exist, but this code is complicated enough.
    end
  end

  def update
    @song.update(song_params)
    save_song and return
    render :edit
  end

  def destroy
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end

  def find_song
    @song = Song.find(params[:id])
  end

  def save_song # This can probably be combined with #save_artist and placed in the ApplicationController.
    if @song.save
      redirect_to @song
    end
  end

  def check_for_nil_artist
    find_artist(params[:artist_id]) # find_artist is defined in the ApplicationController.

    if @artist.nil?
      redirect_to artists_path, alert: "Artist not found"
    end
  end

  def check_for_nil_artist_song
    redirect_to artist_songs_path(@artist), alert: "Song not found" if @song.nil?
  end
end

# ---- Old code from the edit action ----
# if @artist.nil?
        # redirect_to artists_path, alert: "Artist not found"
        # Weird bug here: If I accidentally say artist_path, it redirects to /artists/:id, where :id is the SONG'S id.
      # else
        # @song = @artist.songs.find_by_id(params[:id])
        # redirect_to artist_songs_path(@artist), alert: "Song not found" if @song.nil?
        # Once I figure out how to write controller-specific helpers, I can probably refactor the line above.
        
        # And for some reason, redirecting doesn't permanently exit this method, so I can't do this:
        # redirect_to artists_path, alert: "Artist not found" if @artist.nil?
        # Update: See new code for edit action. 
        
        # binding.pry
        # @song = @artist.songs.find_by_id(params[:id])
        # redirect_to artist_songs_path(@artist), alert: "Song not found" if @song.nil?
      # If @artist is nil, @song = @artist.songs... breaks despite the redirect above it.
    # end
# else 
  # @song = Song.find(params[:id])
  # Ideally, I would redirect to /songs if the song doesn't exist, but this code is complicated enough.
# end
# ---- End of old code from edit action ----

# ---- Old code from the create and update actions: ----
    # if @song.save
      # redirect_to @song
    # else
      # render :new
    # end
# ---- End of old code from the create and update actions ----