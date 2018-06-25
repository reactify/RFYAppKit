//
//  RFYCache.h
//  RFYAppKit
//
//  Created by Ragnar Hrafnkelsson on 06/03/2018.
//  Copyright © 2018 Reactify. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Adapted from the Backchannel SDK
// https://github.com/backchannel/BackchannelSDK-iOS/blob/master/Source/Table%20View/BAKCache.h

@interface RFYCache : NSObject

+ (void)enable;
+ (void)disable;

+ (void)clearAllCaches;

@property (nonatomic, readonly) NSString* name;

- (instancetype)initWithName:(NSString *)name;

- (void)saveObject:(id<NSCoding>)object;

- (id<NSCoding>)fetchObject;

- (void)removeCache;

@end

NS_ASSUME_NONNULL_END
