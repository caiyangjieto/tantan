//
//  NSMutableDictionary+Safe.h
//  tantan
//
//  Created by qitmac000224 on 2018/5/14.
//  Copyright © 2018年 qunar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableDictionary (Safe)

- (void)setObjectSafe:(id)anObject forKey:(id <NSCopying>)aKey;

@end
