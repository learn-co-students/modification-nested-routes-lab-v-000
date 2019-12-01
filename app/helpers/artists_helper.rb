module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end
  # a helper to display a drop-down list of artists if someone edits a song directly via /songs/id/edit
  # and to only display the artist's name if they are editing through nested routing
  def artist_select(song, path_type)
    # display the artist's name if editing through nested routing
    if path_type == "nested"
      hidden_field_tag "song[artist_id]", song.artist_id
      display_artist(song)
    else # display a drop-down list of artists if editing directly via /songs/id/edit
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
    end
  end
end
