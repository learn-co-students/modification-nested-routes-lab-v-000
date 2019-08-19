module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

end


#display a drop-down list of artists if someone edits a song directly via /songs/id/edit
#only display the artist's name if they are editing through nested routing
