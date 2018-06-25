//
//  RFYTask.m
//  RFYAppKit
//
//  Created by Ragnar Hrafnkelsson on 09/05/2018.
//  Copyright © 2018 Reactify. All rights reserved.
//

#import "RFYTask.h"

@interface RFYTask ()
@property (nonatomic,copy) RFYCompletionBlock completionBlock;
@end

@implementation RFYTask

- (RFYTask *)onCompletion:(RFYCompletionBlock)block {
  self.completionBlock = block;
  return [RFYTask new];
}

- (void)setComplete {
  dispatch_async(dispatch_get_main_queue(), ^{
    __weak typeof(self) wSelf = self;
    self.completionBlock(wSelf);
  });
}

@end
