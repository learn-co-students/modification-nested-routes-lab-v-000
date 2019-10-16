class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new

    # deleted code
    # @song = Song.new

    # https://learn.co/tracks/full-stack-web-development-v8/module-13-rails/section-10-routes-and-resources/modifying-nested-resources-lab
    # Using nested resources, set up routes and controller actions to create
    # new song records through an artist.
    # Hint: Don't forget to update the strong parameters.

    # Set up routes and controller actions to support editing a song as a
    # nested resource of an artist.

    # new code start
    if params[:artist_id] && !Artist.exists?(params[:artist_id])
      # # https://learn.co/tracks/full-stack-web-development-v8/module-13-rails/section-10-routes-and-resources/modifying-nested-resources-lab
      # Validate that new songs created for an artist via nested routing are
      # created for valid artists, and redirect to /artists if not.
      # 2.3.3 :002 > app.artists_path
      # => "/artists" (artists_path is the form helper, "/artists" is the URL path)
      redirect_to artists_path, alert: "Artist not found."
    else
      @song = Song.new(artist_id: params[:artist_id])
    end
    # new code end

  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit

    # deleted code
    # @song = Song.find(params[:id])

    # new code start
    if params[:artist_id]
      # https://learn.co/tracks/full-stack-web-development-v8/module-13-rails/section-10-routes-and-resources/modifying-nested-resources-lab
      # Validate that songs being edited via nested routing have a valid artist....
      artist = Artist.find_by(id: params[:artist_id])
      if artist.nil?
        # Redirect to /artists if not.
        redirect_to artists_path, alert: "Artist not found."
      else
        # Validate that songs being edited via nested routing are in the artist's songs collection....
        @song = artist.songs.find_by(id: params[:id])
        # ...Redirect to /artists/id/songs if not.
        redirect_to artist_songs_path(artist), alert: "Song not found." if @song.nil?
      end
    else
      @song = Song.find(params[:id])
    end
    # new code end

  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params

    # deleted code
    # params.require(:song).permit(:title, :artist_name)

    # https://learn.co/tracks/full-stack-web-development-v8/module-13-rails/section-10-routes-and-resources/modifying-nested-resources-lab
    # Using nested resources, set up routes and controller actions to create
    # new song records through an artist.
    # Hint: Don't forget to update the strong parameters.  (Updates below:)
    # new code start
    params.require(:song).permit(:title, :artist_name, :artist_id)
    # new code end

  end
end
