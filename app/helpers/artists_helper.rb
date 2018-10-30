module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  def artist_select(song, artist)
    song.artist.nil? ? collection_select(:song, :name, Artist.all, :id, :name) : display_artist(song)
  end
end
