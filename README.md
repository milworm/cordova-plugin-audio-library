# cordova-plugin-audio-library
Cordova/Ionic plugin that allows to get user's audio library (list of songs) on both ios and android platforms. It also allows to play an item on iOS device

##examples
####Getting list of songs
```
window.cordova.plugins.AudioLibrary.getItems(function(items) {
  items = JSON.parse(items);
});
```
Each item in items is an object, for instance:
```
{
  id: "11111111",
  title: "Song name",
  artist: "Artist name",
  duration: 500,
  path: "path_to_song" //on iOS it's "ipod-library://item.mp3?id=**"
}
```

####Playing an audio track (IOS only).
```
window.cordova.plugins.AudioLibrary.play("11111111", function() {
  // started playing.
});
```

####Pausing an audio track (IOS only).
```
window.cordova.plugins.AudioLibrary.pause(function() {
  // paused.
});
```
