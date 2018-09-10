module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  #<h3> by <%= link_to display_artist(@song), artist_path(@song.artist) if @song.artist %>
  #  (<%= link_to "Edit Song", edit_artist_song_path(@song.artist, @song) if @song.artist %>)</h3>

  def artist_select(artist, song)
    if artist
      artist.name
    else
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
    end
  end

end
