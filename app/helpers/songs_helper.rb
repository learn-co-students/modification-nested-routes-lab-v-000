module SongsHelper
  #reate a helper to display a drop-down list of artists if someone edits a song
  #directly via /songs/id/edit and to only display the artist's name if they are
  #editing through nested routing. Name the helper method artist_select
  def artist_select(form_item, song)
    if song.artist.nil?
      form_item.label :artist_name
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
    else
      hidden_field_tag "song[artist_id]", song.artist_id
    end
  end
end
