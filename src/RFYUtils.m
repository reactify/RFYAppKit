//
//  RFYUtils.m
//  RFYAppKit
//
//  Created by Ragnar Hrafnkelsson on 15/04/2018.
//  Copyright © 2018 Reactify. All rights reserved.
//

#import "RFYUtils.h"

void rfy_safelyRemoveObserver(id object, id observer, NSString* keyPath, void* context) {
  @try {
    [object removeObserver:observer forKeyPath:keyPath context:context];
  }
  @catch (NSException * __unused exception) {
    NSLog(@"Exception thrown: %@", exception.reason);
  }
}

NSString* rfy_alphanumericString(NSString* str) {
  static NSCharacterSet* charactersToRemove = nil;
  if ( !charactersToRemove ) {
    charactersToRemove = NSCharacterSet.alphanumericCharacterSet.invertedSet;
  }
  return [[str componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
}

UIViewController* rfy_topViewControllerWithRootViewController(UIViewController* rootViewController) {
  if ( [rootViewController isKindOfClass:[UITabBarController class]] ) {
    let tabBarController = (UITabBarController *)rootViewController;
    return rfy_topViewControllerWithRootViewController(tabBarController.selectedViewController);
  } else if ( [rootViewController isKindOfClass:[UINavigationController class]] ) {
    let navigationController = (UINavigationController *)rootViewController;
    return rfy_topViewControllerWithRootViewController(navigationController.visibleViewController);
  } else if (rootViewController.presentedViewController) {
    let presentedViewController = rootViewController.presentedViewController;
    return rfy_topViewControllerWithRootViewController(presentedViewController);
  } else {
    return rootViewController;
  }
}
