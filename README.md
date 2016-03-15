# cordova-plugin-audio-library
Cordova/Ionic plugin that allows to get user's audio library (list of songs) on both iOS and Android platforms. 
It also supports play/pause functionality.

####Support
[![Support](https://supporter.60devs.com/api/b/399936c021d5111d90001de85283a4b5)](https://supporter.60devs.com/give/399936c021d5111d90001de85283a4b5)

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

## How to play/pause songs?
This section is specifically for an iOS (on Android `items[index].path` is a path that you can use in HTML5 `audio` tag). To play a song you need to call `initQueue` with an id of the first track that should be played. Then simply call `play`.

####Initialize an audio queue.
```
window.cordova.plugins.AudioLibrary.initQueue(items[0].id, function() {
  // playing queue is initialized, call #play to start playing from the first song.
});
```

####Start playing a queue.
```
window.cordova.plugins.AudioLibrary.play(function() {
  // first song in audio queue is now playing.
});
```

####Pause an active audio track.
```
window.cordova.plugins.AudioLibrary.pause(function() {
  // song is paused.
});
```
