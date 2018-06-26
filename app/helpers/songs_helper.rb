module SongsHelper
    def artist_id_field(song)
        if song.artist.nil?
            select_tag "song[artist_id]", options_for_collection_from_select(Artist.all, :id, :name)
        else 
            hidden_field_tag "song[artist_id]", song.artist_id
        end
    end
end
