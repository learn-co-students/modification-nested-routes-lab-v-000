module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

 def artist_select(artist, song) #see if there is an artist or offer artist options
   if artist
     artist.name #display the artist's name if there is an artist
   else #if there is no artist, offer selections from all artists
     select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
   end
 end

end
