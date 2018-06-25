//
//  NSArray+RFYUtilities.h
//  RFYAppKit
//
//  Created by Ragnar Hrafnkelsson on 20/02/2018.
//  Copyright © 2018 Reactify. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+ObjectiveSugar.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<__covariant ObjectType> (RFYUtilities)

- (__nullable ObjectType)rfy_safeObjectAtIndex:(NSUInteger)index;

// Borrowed from https://github.com/marcoarment/FCUtilities
- (NSArray<ObjectType> *)rfy_filteredArrayUsingBlock:(BOOL (^)(ObjectType obj, NSUInteger idx, BOOL *stop))block;

// Returns all objects in front of object passed
- (NSArray<ObjectType> *)rfy_before:(ObjectType)object;

// Returns all objects up until and inclusive of 'object'
- (NSArray<ObjectType> *)rfy_until:(ObjectType)object;

// Returns all objects behind object passed, inclusive of 'object'
 - (NSArray<ObjectType> *)rfy_from:(ObjectType)object;

// Returns all objects behind object passed
- (NSArray<ObjectType> *)rfy_after:(ObjectType)object;

@end

@interface NSMutableArray (RFYUtilities)
// Borrowed from https://github.com/marcoarment/FCUtilities
- (void)rfy_moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end

NS_ASSUME_NONNULL_END
