module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  #what is the purpose of the method below, and how does it work? Could the same song_helper from 
  #   the readme lesson before this lab have worked, or not because we needed arguments of artist and song?
  #   the code in songs_helper.rb is commented out

  def artist_select(artist, song)
    if artist
      artist.name
    else
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
    end
  end
end