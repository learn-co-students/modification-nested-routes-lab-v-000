module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  def artist_select(song, artist)
    if artist   
      hidden_field_tag "song[artist_id]", song.artist_id
    else
      # <!--
        # <%#= f.label :artist_name %> <!-- So, despite the Song#artist_name method, this isn't needed.
        # <%#= f.text_field :artist_name %> <!-- Or this, for that matter.
      # -->

      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name, selected = song.artist_id)
      # Is it possible to have the song's artist selected from that list by default?
      # Edit: Yes, just use "selected = song.artist_id", as shown above.
    end
  end
end
