//
//  RFYAudioStemsPlayer.h
//  RFYAppKit
//
//  Created by Ragnar Hrafnkelsson on 14/04/2018.
//  Copyright © 2018 Reactify. All rights reserved.
//

#import "RFYAudioPlayable.h"
#import "RFYAudioFilePlayer.h"

// This object currently assumes that all stems are of same length

@interface RFYAudioStemsPlayer : NSObject <RFYAudioPlayable>

@property (nonatomic, weak) id<RFYAudioFilePlayerDelegate> delegate;

// TODO: Report errors
- (instancetype)initWithFiles:(NSArray<NSURL *>*)urls error:(NSError **)outError;

// Calls stop: before loading a new file
- (BOOL)loadFiles:(NSArray<NSURL *>*)files;

@end
