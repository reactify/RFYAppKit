//
//  RFYTask.h
//  RFYAppKit
//
//  Created by Ragnar Hrafnkelsson on 09/05/2018.
//  Copyright © 2018 Reactify. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RFYTask<__covariant ObjectType> : NSObject

typedef __nullable id(^RFYCompletionBlock)(RFYTask* task);

@property (nonatomic) BOOL success;

@property (nonatomic) NSError* error;

@property (nonatomic) ObjectType result; // Optional return value

- (RFYTask *)onCompletion:(RFYCompletionBlock)block;

// Calls completion handler asynchronously on main thread
- (void)setComplete;

@end

NS_ASSUME_NONNULL_END
