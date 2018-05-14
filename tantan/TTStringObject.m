//
//  TTStringObject.m
//  tantan
//
//  Created by qitmac000224 on 2018/5/14.
//  Copyright © 2018年 qunar. All rights reserved.
//

#import "TTStringObject.h"

@implementation TTStringObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _text = [NSMutableString new];
        _attributed = [NSMutableDictionary new];
    }
    return self;
}
@end
