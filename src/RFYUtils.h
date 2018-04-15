//
//  RFYUtils.h
//  RFYAppKit
//
//  Created by Ragnar Hrafnkelsson on 15/04/2018.
//  Copyright © 2018 Reactify. All rights reserved.
//

#ifndef RFYUtils_h
#define RFYUtils_h

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// Safe block execution
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

#define RFY_INLINE inline __attribute__((always_inline))

// https://medium.com/@maicki/type-inference-with-auto-type-55a38ef56372
#define let __auto_type const
#define var __auto_type

#define RFYMainThreadAssert() NSAssert( [NSThread isMainThread], @"Must be called from the main thread" )

static RFY_INLINE NSString* rfy_safeString(NSString* _Nullable str) { return str ? str : @""; }

// Safely removes KVO observer, catching exception if one is thrown
void rfy_safelyRemoveObserver(id object, id observer, NSString* keyPath, void* context);

// Strips non-alphanumeric characters from string
NSString* rfy_alphanumericString(NSString* str);

UIViewController* rfy_topViewControllerWithRootViewController(UIViewController* rootVC);

static RFY_INLINE UIViewController* rfy_topViewController() {
  let window = [UIApplication sharedApplication].keyWindow;
  let rootVC = window.rootViewController;
  return rfy_topViewControllerWithRootViewController(rootVC);
}

static RFY_INLINE NSString* rfy_bundleName() {
  let info = [[NSBundle mainBundle] infoDictionary];
  return [info objectForKey:(NSString *)kCFBundleNameKey];
}

#define RFYMainStoryboard() [UIStoryboard storyboardWithName:@"Main" bundle:nil]

// Swift style type comparison
#define is isKindOfClass:

NS_ASSUME_NONNULL_END

#endif /* RFYUtils_h */
