module ArtistsHelper

  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  def artist_select(artist, song)
    artist.name if artist else select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)     # options_from_collection_for_select(collection, value_method, text_method, selected = nil)

  end

end
