//
//  Socore.m
//  PingPong
//
//  Created by Павел Нехорошкин on 02.04.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import "Score.h"
#import "ViewController.h"

@implementation Score


- (instancetype) initWithScreenFrame:(CGRect)frame
{
    self = [super init];
    
    if (self) {

        self.frame = CGRectMake(frame.size.width - 130, 40, 120, 40);
        self.textAlignment = NSTextAlignmentRight;
        self.textColor = UIColor.redColor;
        self.text = @"SCORE: 0";
        [self setFont:[UIFont systemFontOfSize:18]];
    }
    return self;
}
@end
