//
//  TTStringHandle.m
//  tantan
//
//  Created by qitmac000224 on 2018/5/14.
//  Copyright © 2018年 qunar. All rights reserved.
//

#import "TTStringHandle.h"
#import "NSMutableDictionary+Safe.h"

@implementation TTStringHandle

+ (NSArray *)handleTextSegment:(NSString *)text
{
    NSMutableArray *arrayTestSegment = [NSMutableArray new];
    NSMutableString *testSegment = [NSMutableString new];
    for(int i =0; i < [text length]; i++)
    {
        NSString *temp = [text substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"<"])
        {
            [arrayTestSegment addObject:testSegment];
            testSegment = [NSMutableString new];
            [testSegment appendString:temp];
        }
        else if ([testSegment hasPrefix:@"<"] && [temp isEqualToString:@">"])
        {
            [testSegment appendString:temp];
            [arrayTestSegment addObject:testSegment];
            testSegment = [NSMutableString new];
        }
        else
        {
            [testSegment appendString:temp];
        }
    }
    
    NSMutableArray *arrayStringObject = [NSMutableArray new];
    TTStringObject *stringObject = [[TTStringObject alloc] init];
    for (NSString *textSegment in arrayTestSegment)
    {
        if ([textSegment hasPrefix:@"</"] && [textSegment hasSuffix:@">"])
        {
            [arrayStringObject addObject:stringObject];
            stringObject = [[TTStringObject alloc] init];
        }
        else if ([textSegment hasPrefix:@"<"] && [textSegment hasSuffix:@">"])
        {
            [arrayStringObject addObject:stringObject];
            stringObject = [[TTStringObject alloc] init];
            
            NSString *temp = [textSegment substringFromIndex:3];
            temp = [temp substringToIndex:temp.length-1];
            NSArray *array = [temp componentsSeparatedByString:@"="];
            for(int i = 0; i < [array count]; i+=2)
            {
                NSString *key = array[i];
                NSString *value = array[i+1];
                value = [value stringByReplacingOccurrencesOfString:@"“" withString:@""];
                [stringObject.attributed setObjectSafe:value forKey:key];
            }
        }
        else
        {
            [stringObject.text appendString:textSegment];
        }
    }
    
    return arrayStringObject;
}

@end
