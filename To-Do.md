Using nested resources, 
[x] set up routes and controller actions to create new song records through an artist. Hint: Don't forget to update the strong parameters.
[x] Set up routes and controller actions to support editing a song as a nested resource of an artist.
[x] Create a helper to display a drop-down list of artists if someone edits a song directly via /songs/id/edit and to 
    [x] only display the artist's name if they are editing through nested routing. Name the helper method artist_select. Hint: You'll need to set a variable in the controller action to pass to the helper method as an argument along with a song instance.
[x] Validate that new songs created for an artist via nested routing are created for valid artists, and 
    [x] redirect to /artists if not.
[x] Validate that songs being edited via nested routing have a valid artist. 
    [x] Redirect to /artists if not.
[] Validate that songs being edited via nested routing are in the artist's songs collection.
    [] Redirect to /artists/id/songs if not.