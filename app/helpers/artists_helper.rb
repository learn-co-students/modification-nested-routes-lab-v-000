module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  def artist_select(song, artist)
    if artist.valid?
      display_artist(song)
    else
      collection_select(:song, :name, Artist.all, :id, :name)
    end
  end
end
