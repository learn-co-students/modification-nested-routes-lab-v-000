module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  def artist_select(song, artist)
    if params[:artist_id]
      artist.name
    else
      collection_select :artist_id, artist, :id, :artist_name
    end

  end


end
