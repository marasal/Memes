# Memes
## Project Overview

MemeMe is a meme-generating app that enables a user to attach a caption to a picture from their phone. After adding text to an image chosen from the Photo Album or Camera, the user can share it with friends. MemeMe also temporarily stores sent memes which users can browse in a table or a grid.

## Implementation
The app has three view controller scenes:

- EditorController - consists of an image view overlaid by two text fields, one near the top and one near the bottom of the image. To create meme user should pick photo from the camera or existing photo album.

- TableController and CollectionController - displays recently sent memes. It has a bottom toolbar with tabs that allow the user to toggle between viewing sent memes in a table and viewing them in a grid.

- PreviewController - displays the selected meme in an image view in the center of the page with the meme’s original aspect ratio. User also be able to share or save meme as file by clicking the appropriate button in the navigation bar.
