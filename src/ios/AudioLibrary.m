/********* AudioLibrary.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AudioLibrary : CDVPlugin {
  // Member variables go here.
}

- (void)getItems:(CDVInvokedUrlCommand*)command;
- (void)play:(CDVInvokedUrlCommand*)command;
- (void)pause:(CDVInvokedUrlCommand*)command;

@end

@implementation AudioLibrary

- (void)getItems:(CDVInvokedUrlCommand*)command
{
    MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];

    NSArray *songs = [songsQuery items];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[songs count]];

    for (MPMediaItem *song in songs) {
        NSString *artist = [song valueForProperty: MPMediaItemPropertyArtist];

        if (artist == nil) 
            artist = @"Unknown";

        NSURL *url = [song valueForProperty: MPMediaItemPropertyAssetURL];
        NSString *path = [NSString stringWithFormat:@"%@",[url absoluteString]];

        NSDictionary *item = @{
            @"id": [[song valueForProperty: MPMediaItemPropertyPersistentID] stringValue],
            @"title" : [song valueForProperty: MPMediaItemPropertyTitle],
            @"artist": artist,
            @"duration": [song valueForProperty: MPMediaItemPropertyPlaybackDuration],
            @"path": path
        };

        [result addObject:item];
    }

    NSArray *arrayResult = [NSArray arrayWithArray:result];

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:arrayResult];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)initQueue:(CDVInvokedUrlCommand*)command
{   
    NSString *persistentID = [command.arguments objectAtIndex:0];

    MPMediaQuery *songsQuery = [[MPMediaQuery alloc] init];
    MPMusicPlayerController *player = [MPMusicPlayerController systemMusicPlayer];

    NSArray *items = [songsQuery items];
    NSMutableArray *result = [[NSMutableArray alloc] init];

    BOOL found = NO;

    for(MPMediaItem *item in items) {
        NSString *itemId = [[item valueForProperty: MPMediaItemPropertyPersistentID] stringValue];

        if([persistentID isEqualToString:itemId])
            found = YES;

        if(found == YES)
            [result addObject:item];
    }

    NSArray *arrayResult = [NSArray arrayWithArray:result];

    [player setQueueWithItemCollection: [MPMediaItemCollection collectionWithItems: arrayResult]];
    [player setNowPlayingItem: result[0]];
    [player pause];
    // [player skipToBeginning];

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)play:(CDVInvokedUrlCommand*)command
{
    MPMusicPlayerController *player = [MPMusicPlayerController systemMusicPlayer];
    [player play];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)pause:(CDVInvokedUrlCommand*)command
{
    MPMusicPlayerController *player = [MPMusicPlayerController systemMusicPlayer];
    [player pause];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
