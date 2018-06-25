//
//  RFYPermissions.m
//  RFYAppKit
//
//  Created by Ragnar Hrafnkelsson on 11/05/2018.
//  Copyright © 2018 Reactify. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "RFYUtils.h"
#import "RFYTask.h"
#import "RFYErrors.h"
#import "RFYPermissions.h"

@implementation RFYPermissions

+ (RFYTask *)requestMicrophoneAccess {
  let task = [RFYTask new];
  [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
    if ( status != MPMediaLibraryAuthorizationStatusAuthorized ) {
      task.error = [RFYErrors userRejectedMicrophoneAccess];
    } else {
      task.success = YES;
    }
    [task setComplete];
  }];
  return task;
}

@end
