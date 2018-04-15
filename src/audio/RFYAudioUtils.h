//
//  RFYAudioUtils.h
//  RFYAppKit
//
//  Created by Ragnar Hrafnkelsson on 15/04/2018.
//  Copyright © 2018 Reactify. All rights reserved.
//

#ifndef RFYAudioUtils_h
#define RFYAudioUtils_h

#import <AVFoundation/AVFoundation.h>
#import "RFYUtils.h"

#define checkResult(result,operation) (_checkResult((result),(operation),strrchr(__FILE__, '/')+1,__LINE__))
static RFY_INLINE BOOL _checkResult(OSStatus result, const char *operation, const char* file, int line) {
  if ( result != noErr ) {
    NSLog(@"%s:%d: %s result %d %08X %4.4s\n", file, line, operation, (int)result, (int)result, (char*)&result);
    return NO;
  }
  return YES;
}

AudioStreamBasicDescription nonInterleavedFloatStereo(void);

AudioBufferList *InitAudioBufferList(AudioStreamBasicDescription audioFormat, int frameCount);

void FreeAudioBufferList(AudioBufferList *bufferList);

#endif /* RFYAudioUtils_h */
