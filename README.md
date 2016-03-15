# cordova-plugin-audio-library
Cordova/Ionic plugin that allows to get user's audio library (list of songs) on both ios and android platforms. It also allows to play an item on iOS device (on Android you can use HTML5 "audio" tag)

##Installation
```
git clone https://github.com/milworm/cordova-plugin-audio-library.git
ionic plugin add ./cordova-plugin-audio-library
```

##Examples
####List of songs
```
window.cordova.plugins.AudioLibrary.getItems(function(items) {
  // your code
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

####Initialize an audio queue (IOS only).
```
window.cordova.plugins.AudioLibrary.initQueue(items[0].id, function() {
  // playing queue is ready
});
```

####Play a queue (IOS only).
```
window.cordova.plugins.AudioLibrary.play(function() {
  // first song in audio queue is started playing.
});
```

####Pause an audio track (IOS only).
```
window.cordova.plugins.AudioLibrary.pause(function() {
  // song is paused.
});
```
