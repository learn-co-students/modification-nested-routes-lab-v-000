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
    if params[:artist_id] && !Artist.exists?(params[:author_id])
      redirect_to artists_path, alert: "Artist not found."
    else 
      @song = Song.new(artist_id: params[:artist_id])
    end
  end


# def new
#   if params[:author_id] && !Author.exists?(params[:author_id])
#     redirect_to authors_path, alert: "Author not found."
#   else
#     @post = Post.new(author_id: params[:author_id])
#   end
# end



  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
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
    params.require(:song).permit(:title, :artist_name)
  end
end




  # describe "GET new" do
  #   it "sets artist when nested route" do
  #     get :new, artist_id: @artist.id
  #     expect(assigns(:song).artist_id).to eq @artist.id
  #   end

  #   it "validates artist when nested route" do
  #     get :new, artist_id: 123123
  #     expect(response).to redirect_to artists_path
  #   end
  # end

  # describe "POST create" do
  #   it "accepts and sets artist_id" do
  #     post :create, song: {artist_id: @artist.id, title: "This is a test song!"}
  #     expect(Song.last.artist_id).to eq @artist.id
  #   end
  # end

  # describe "GET edit" do
  #   it "validates artist when nested" do
  #     get :edit, artist_id: 1234, id: @song.id
  #     expect(response).to redirect_to artists_path
  #   end

  #   it "validates song for artist when nested" do
  #     get :edit, artist_id: @artist.id, id: 1234
  #     expect(response).to redirect_to artist_songs_path(@artist)
  #   end
  # end

  # describe "GET index" do

  #   it "redirects when artist not found" do
  #     get :index, artist_id: "abc"
  #     expect(response).to redirect_to artists_path
  #   end

  #   it 'returns 200 when just index with no artist_id' do
  #     get :index
  #     expect(response).to be_ok
  #   end

  # end

  # describe "GET show with  artist" do

  #   it "returns 200 with valid song and no artist" do
  #     get :show, id: @song.id
  #     expect(response).to be_ok
  #   end

  #   it "redirects to artists songs when artist song not found" do
  #     get :show, id: 12345, artist_id: @artist.id
  #     expect(controller).to set_flash[:alert]
  #     expect(response).to redirect_to artist_songs_path(@artist)
  #   end

  #   it "returns 200 with valid artist song" do
  #     get :show, id: @song.id, artist_id: @artist.id
  #     expect(response).to be_ok
  #   end
  # end

