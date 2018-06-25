//
//  NSArray+RFYUtilities.m
//  RFYAppKit
//
//  Created by Ragnar Hrafnkelsson on 20/02/2018.
//  Copyright © 2018 Reactify. All rights reserved.
//

#import "RFYUtils.h"
#import "NSArray+RFYUtilities.h"

@implementation NSArray (RFYUtilities)

- (id)rfy_safeObjectAtIndex:(NSUInteger)index {
  return (index < self.count) ? self[index] : nil;
}

- (NSArray *)rfy_filteredArrayUsingBlock:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))block {
  return [self objectsAtIndexes:[self indexesOfObjectsPassingTest:block]];
}

- (NSArray *)rfy_before:(id)anObject {
  let index = [self indexOfObject:anObject];
  return [self rfy_filteredArrayUsingBlock:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    return idx < index;
  }];
}

- (NSArray *)rfy_until:(id)object {
  let before = [self rfy_before:object];
  return object ? [before arrayByAddingObject:object] : before;
}

- (NSArray *)rfy_from:(id)object {
  let array = object ? @[object] : @[];
  return [array arrayByAddingObjectsFromArray:[self rfy_after:object]];
}

- (NSArray *)rfy_after:(id)anObject {
  let index = [self indexOfObject:anObject];
  return [self rfy_filteredArrayUsingBlock:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    return index < idx;
  }];
}

@end

@implementation NSMutableArray (RFYUtilities)

- (void)rfy_moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
  id object = [self objectAtIndex:fromIndex];
  [self removeObjectAtIndex:fromIndex];
  [self insertObject:object atIndex:toIndex];
}

@end
