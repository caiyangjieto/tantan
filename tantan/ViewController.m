//
//  ViewController.m
//  tantan
//
//  Created by qitmac000224 on 2018/5/14.
//  Copyright © 2018年 qunar. All rights reserved.
//

#import "ViewController.h"
#import "TTFeedbackViewController.h"
#import "TTStringHandle.h"

@interface ViewController () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.textView = [[UITextView alloc] init];
    [self.textView setFrame:CGRectMake(50, 150, 250, 100)];
    [self.textView setEditable:NO];
    [self.textView setDelegate:self];
    [self.view addSubview:self.textView];
    
    NSString *text = @"欢迎使用探探, 在使用过程中有疑问请<a href=“tantanapp://feedback“>反馈</a>";
    NSArray *arrayStringObject = [TTStringHandle handleTextSegment:text];
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] init];
    for (TTStringObject *stringObject in arrayStringObject)
    {
        if (stringObject.text.length == 0) {
            continue;
        }
        
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:stringObject.text];
        [attributeStr appendAttributedString:string];
        
        for (NSString *key in stringObject.attributed.allKeys)
        {
            if ([key isEqualToString:@"href"])
            {
                NSString *value = stringObject.attributed[key];
                NSURL *url = [NSURL URLWithString:value];
                [attributeStr addAttribute:NSLinkAttributeName value:url range:NSMakeRange(attributeStr.length-stringObject.text.length, stringObject.text.length)];
                [attributeStr addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(attributeStr.length-stringObject.text.length, stringObject.text.length)];
            }
        }
    }
    self.textView.attributedText = attributeStr;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)url inRange:(NSRange)characterRange
{
    NSString *scheme = url.scheme;
    if ([scheme isEqualToString:@"tantanapp"])
    {
        NSString *actType = url.host;
        if ([actType isEqualToString:@"feedback"])
        {
            TTFeedbackViewController *feedbackVC = [[TTFeedbackViewController alloc] init];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }
        return NO;
    }
    
    return YES;
}

@end
