    <!-- sets artist when nested route -->

    <!-- i was trying to use a datalist. but i had to go to the new route in
    the songs controller and manually set the artist for the song
    @song.artist = Artist.find_or_create_by(params[:artist_id])

    because in a nested route, the artist_id is in the params, but is not automatically associated with the song. you have to do that yourself in the controller  -->
