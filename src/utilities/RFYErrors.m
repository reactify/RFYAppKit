//
//  RFYErrors.m
//  RFYAppKit
//
//  Created by Ragnar Hrafnkelsson on 11/05/2018.
//  Copyright © 2018 Reactify. All rights reserved.
//

#import "RFYUtils.h"
#import "RFYErrors.h"

static NSString *RFYCustomErrorDomain = nil;

@implementation RFYErrors

+ (void)setErrorDomain:(NSString *)domain {
  RFYCustomErrorDomain = domain;
}

+ (NSError *)userRejectedMicrophoneAccess {
  let userInfo = @{
                   NSLocalizedDescriptionKey:NSLocalizedString(@"Microphone access not authorised.", @"Todo"),
                   NSLocalizedFailureReasonErrorKey:NSLocalizedString(@"Access request rejected by user.", @"Todo"),
                   NSLocalizedRecoverySuggestionErrorKey:NSLocalizedString(@"Ask user to allow access in Privacy Settings", @"Todo")
                   };
  return [NSError errorWithDomain:[self errorDomain]
                             code:11001
                         userInfo:userInfo];
}

+ (NSString *)errorDomain {
  return RFYCustomErrorDomain?: rfy_bundleId();
}

@end
