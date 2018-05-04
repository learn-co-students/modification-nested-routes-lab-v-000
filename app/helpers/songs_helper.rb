module SongsHelper

	def song_edit_display(song)
		if song.artist.nil?
			link_to "Edit Post", edit_song_path(song)
		else 
			link_to "Edit Post", edit_artist_song_path(@song.artist, @song) 
		end 
	end 
			
end
