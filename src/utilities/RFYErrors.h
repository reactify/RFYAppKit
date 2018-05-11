//
//  RFYErrors.h
//  RFYAppKit
//
//  Created by Ragnar Hrafnkelsson on 11/05/2018.
//  Copyright © 2018 Reactify. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFYErrors : NSObject

// Set a custom error domain. The default is based on the app bundle id
+ (void)setErrorDomain:(NSString *)domain;

/* Common errors */
 
+ (NSError *)userRejectedMicrophoneAccess;

@end
