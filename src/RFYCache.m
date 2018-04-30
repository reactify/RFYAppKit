//
//  RFYCache.m
//  musiclarity
//
//  Created by Ragnar Hrafnkelsson on 06/03/2018.
//  Copyright © 2018 Reactify. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>
#import "RFYUtils.h"
#import "RFYCache.h"

@implementation RFYCache

static BOOL _enabled = YES;

+ (void)enable {
  _enabled = YES;
}

+ (void)disable {
  _enabled = NO;
}

+ (void)clearAllCaches {
  let cache = [RFYCache new];
  [[NSFileManager defaultManager] removeItemAtPath:cache.appCacheDirectory error:nil];
}

- (instancetype)initWithName:(NSString *)name {
  self = [super init];
  if ( !_enabled || !name ) self = nil;
  if ( self ) {
    _name = name;
  }
  return self;
}

- (void)saveObject:(id<NSCoding>)object {
  [NSKeyedArchiver archiveRootObject:object toFile:self.cacheLocation];
}

- (id<NSCoding>)fetchObject {
  return [NSKeyedUnarchiver unarchiveObjectWithFile:self.cacheLocation];
}

- (void)removeCache {
  [[NSFileManager defaultManager] removeItemAtPath:self.cacheLocation error:nil];
}

- (NSString *)cacheLocation {
  let fileManager = [NSFileManager defaultManager];
  if ( ![fileManager fileExistsAtPath:self.appCacheDirectory isDirectory:nil] ) {
    [fileManager createDirectoryAtPath:self.appCacheDirectory
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:nil];
  }
  return [self.appCacheDirectory stringByAppendingPathComponent:self.cacheFilename];
}

- (NSString *)appCacheDirectory {
  return [self.generalCacheDirectory stringByAppendingPathComponent:rfy_bundleName()];
}

- (NSString *)generalCacheDirectory {
  let searchPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
  return searchPath.firstObject;
}

- (NSString *)cacheFilename {
  return [self.hashedName stringByAppendingPathExtension:@"cache"];
}

- (NSString *)hashedName {
  const char *cString = [self.name UTF8String];
  unsigned char digest[16];
  CC_MD5(cString, (CC_LONG)strlen(cString), digest);
  let output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
  for ( int i = 0; i < CC_MD5_DIGEST_LENGTH; i++ ) {
    [output appendFormat:@"%02x", digest[i]];
  }
  return output;
}

@end
