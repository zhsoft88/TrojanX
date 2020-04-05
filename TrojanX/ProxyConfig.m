//
//  ProxyConfig.m
//  TestMacUtils
//
//  Created by zhsoft88 on 2020/4/5.
//  Copyright © 2020 zhuatang. All rights reserved.
//

#import "ProxyConfig.h"

@implementation ProxyConfig

+ (NSString *)ProxyAutoConfigURLString {
  NSString* result = @"";
  FILE* fp = popen("scutil --proxy", "r");
  if (!fp)
    return result;

  while (!feof(fp)) {
    size_t len = 0;
    char* buf = fgetln(fp, &len);
    if (buf && len > 0) {
      NSString* line = [[NSString alloc] initWithBytes:buf length:len encoding:NSUTF8StringEncoding];
      line = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
      NSRange range = [line rangeOfString:@":"];
      if (range.location == NSNotFound)
        continue;

      NSString* key = [[line substringWithRange:NSMakeRange(0, range.location)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      if ([key isEqualToString:@"ProxyAutoConfigURLString"]) {
        NSString* value = [[line substringFromIndex:range.location + 1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (value.length > 0) {
          result = value;
          break;
        }
      }
    }
  }
  pclose(fp);
  return result;
}

@end
