module ArtistsHelper
  def display_artist(song)
    # song with no artist? link to "add artist", or else link to the artist's page
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  def artist_select(song, artist_id)
    # if the song to edit has an artist
    if !song.artist.nil?
      # use the artist's id to fill in the edit page's 'artist'
      hidden_field_tag "song[artist_id]", artist_id
    else
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
    end
  end
end
