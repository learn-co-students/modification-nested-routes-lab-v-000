module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end
  
  def artist_select(artist, song)
    if artist.nil?
      if song.artist.nil?
        select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
      else 
        hidden_field_tag "song[artist_id]", song.artist_id 
      end 
    end
  end
  
end

# module PostsHelper
#   def author_id_field(post)
#     if post.author.nil?
#       select_tag "post[author_id]", options_from_collection_for_select(Author.all, :id, :name)
#     else
#       hidden_field_tag "post[author_id]", post.author_id
#     end
#   end
# end