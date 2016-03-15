var exec = require('cordova/exec');

exports.getItems = function(success, error) {
    exec(function(items) {
        success(items.constructor == String ? JSON.parse(items) : items);
    }, error, "AudioLibrary", "getItems", [""]);
};

exports.play = function(success, error) {
    exec(success, error, "AudioLibrary", "play", []);
}

exports.pause = function(success, error) {
    exec(success, error, "AudioLibrary", "pause", []);
}

exports.initQueue = function(id, success, error) {
    exec(success, error, "AudioLibrary", "initQueue", [id + ""]);
}