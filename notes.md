Creating nested resources:

nesting songs in artist:
  An artist has_many songs
  A song belongs to an artist

/artists/1/songs: should show an index of all songs for that particular artist.
/artists/1/songs/1: should show the specific song for that specific artist.
/artists/1/songs/1/edit: should edit the specific song for the specific artist.
/artists/1/songs/new: should create a new song for that is linked to that specific artist.

Steps:

/artists/1/songs/new
  1. in the routes, include :new in the nested song routes.

  2. In the new action, we want to check that the user actually exists and safeguard against malicious users that alter the artist_id in the browser's url. Will need to implement an if statement that checks if an author_id was passed in params. This means that the new action is being called from the nested route. If that is the case, then we need to check the database for the actual artist. Here it would make sense to just check the database to see if the author exists using .exists? as opposed to returning an artist object. we wont be doing anything with it here. (unless we need it, then we would use .find_by)

  @song = Song.new(artist_id: params[:artist_id]) this line takes care of linking the newly made song to the artist id. this way you cant create a song for anyone other than the artist that corresponds to the artist_id in the url.

  3. Then do we need to modify the form partial?
  As a preliminary step, if the form is being called from the nested resource, we know that we need to include the artist_id in the form, because ultimately when it gets passed to the create action, it'll need to include the artist id to link the newly created song to the artist.
  Otherwise, if the form isn't being called from the nested route, and instead being called from the /songs/new route, then we don't need the hidden field tag with the artist_id, and instead we need a select tag to choose from a list of available artists.Rather than include the logic in your actual view, makes more sense to include in a helper method.

  4. Now to set up editing a song as a nested resource of artist, we need to think first of what is being passed from the url to the edit controller action. First thing, we are passing an artist_id as well as a song id that is accessed through the artist. meaning, we are accessing artist.songs.find_by(id:1) and NOT Song.find(id:1). The controller action needs to first verify that the artist_id is being passed, and if it is, to validate the existence of the artist. in this case we do need to return the artist object, because we will be using the artist object to access the specific artists specific songs.

  once you have the artist object, you can the set @songs to artist.songs.find_by(id: params[:id])

  5. Assuming that the form partial has a hidden field for artist_id then it doesnt actually need to change anything because it will handle user input and then direct it to the create action. (in other words post to /songs)

  6. the helper method for the edit form. If someone accesses the edit page from /songs/:id/edit, we want to display a select tag to choose from a list of artists. Otherwise, we want to display the artist's name if they are editing through nested routing. something needs to be done in the controller to pass to the view, which will then call the helper method. meaning we need to set an instance variable. the helper method will take in two arguments, probably @song and @artist.
