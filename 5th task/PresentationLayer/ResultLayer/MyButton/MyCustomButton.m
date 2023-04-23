//
//  UIButton+CustomButton.m
//  5th task
//
//  Created by Владимир Курганов on 26.12.2022.
//

#import <UIKit/UIKit.h>
#import "MyCustomButton.h"

//MARK: - @interface MyCustomButton
@interface MyCustomButton()
@end

//MARK: - MyCustomButton
@implementation  MyCustomButton

//MARK: - Init
-(id)initEndButton {
    self = [super init];
    [self.titleLabel setFont:[UIFont fontWithName: @"Rubik-Regular" size: 16]];
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowOpacity = 10;
    self.layer.shadowRadius = 0;
    self.layer.shadowColor = [UIColor colorWithRed:0.78 green:0.843 blue:0.608 alpha:1].CGColor;
    self.layer.borderColor = [UIColor colorWithRed:0.78 green:0.843 blue:0.608 alpha:1].CGColor;
    self.backgroundColor = [UIColor colorWithRed:0.973 green:1 blue:0.894 alpha:1];
    self.layer.cornerRadius = 16;
    self.layer.borderWidth = 2;
    [self setTitle: @"ЗАКОНЧИТЬ" forState: UIControlStateNormal];
    [self setTitleColor:UIColor.blackColor forState: UIControlStateNormal];
    return  self;
}

-(id)initStartButton {
    self = [super init];
    [self.titleLabel setFont:[UIFont fontWithName: @"Rubik-Regular" size: 16]];
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowOpacity = 10;
    self.layer.shadowRadius = 0;
    self.layer.shadowColor = [UIColor colorWithRed:0.133 green:0.545 blue:0.902 alpha:1].CGColor;
    self.layer.borderColor = [UIColor colorWithRed:0.133 green:0.545 blue:0.902 alpha:1].CGColor;
    self.backgroundColor = [UIColor colorWithRed:0.302 green:0.671 blue:0.969 alpha:1];
    self.layer.cornerRadius = 16;
    self.layer.borderWidth = 2;
    [self setTitle: @"НАЧАТЬ СНОВА" forState: UIControlStateNormal];
    [self setTitleColor:UIColor.whiteColor forState: UIControlStateNormal];
    return self;
}

//MARK: - Methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [UIButton animateWithDuration:0.05 animations:^{
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + 2, self.frame.size.width, self.frame.size.height)];
        self.layer.shadowOpacity = 0;
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    [UIButton animateWithDuration:0.05 animations:^{
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y - 2, self.frame.size.width, self.frame.size.height)];
        self.layer.shadowOpacity = 1;
    }];
}

@end







