module SongsHelper

  def artist_id_field(song)
    if song.artist.nil?
      #if navigating thru regular route, print a list of checkboxes to select an artist
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
    else
      #if navigating thru the nested route, place a hidden_field_tag in the form to be submitted so the song is already associated with the artist.
      hidden_field_tag "song[artist_id]", song.artist_id
    end
  end
end
