module SongsHelper

	def artist_select(song, f = nil)
		# binding.pry
		if params[:artist_id].nil?
			song.select(:artist_id, Artist.all.map{|a| [a.name, a.id]}, {include_blank: true})
		else
			"Artist: #{Artist.find_by(id: params[:artist_id]).name}"
		end
	end

end
