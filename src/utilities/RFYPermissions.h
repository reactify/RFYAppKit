//
//  RFYPermissions.h
//  RFYAppKit
//
//  Created by Ragnar Hrafnkelsson on 11/05/2018.
//  Copyright © 2018 Reactify. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RFYTask;

@interface RFYPermissions : NSObject

+ (RFYTask *)requestMicrophoneAccess;

@end
