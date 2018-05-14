//
//  NSMutableDictionary+Safe.m
//  tantan
//
//  Created by qitmac000224 on 2018/5/14.
//  Copyright © 2018年 qunar. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"

@implementation NSMutableDictionary (Safe)

- (void)setObjectSafe:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (anObject && aKey) {
        [self setObject:anObject forKey:aKey];
    }
}

@end
