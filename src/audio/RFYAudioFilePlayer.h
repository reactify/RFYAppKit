//
//  RFYAudioFilePlayer.h
//  RFYAppKit
//
//  Created by Ragnar Hrafnkelsson on 02/06/2017.
//  Copyright © 2017 Reactify. All rights reserved.
//

@import AVFoundation;
#import "RFYAudioPlayable.h"

@class RFYAudioFilePlayer;

@protocol RFYAudioFilePlayerDelegate <NSObject>
// Notify delegate of audio read, for optional processing
// Not called from a realtime thread
- (void)audioFilePlayer:(RFYAudioFilePlayer *)player willQueueAudio:(AudioBufferList *)audio;
- (void)audioFilePlayerDidFinishPlayback:(RFYAudioFilePlayer *)player;
@end

@interface RFYAudioFilePlayer : NSObject <RFYAudioPlayable> {
@protected
  BOOL _isPlaying;
}

// Playback status. KVO observable
@property (nonatomic, readonly) BOOL isPlaying;

// Duration in seconds
@property (nonatomic, readonly) double duration;

// Current playback position in seconds
@property (nonatomic) double currentTime;

@property (nonatomic, weak) id<RFYAudioFilePlayerDelegate> delegate;

// TODO: Report errors
- (instancetype)initWithFile:(NSURL *)url error:(NSError **)outError;

// Calls stop: before loading a new file
- (BOOL)loadFile:(NSURL *)file;

@end
