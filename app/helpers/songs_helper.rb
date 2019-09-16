require 'pry'
module SongsHelper
    def artist_select(artist,song)
        if artist #checking if artist exists
            song.artist.name #displays song artist name
        else #selects artist from collection
            select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
        end
    end
end

