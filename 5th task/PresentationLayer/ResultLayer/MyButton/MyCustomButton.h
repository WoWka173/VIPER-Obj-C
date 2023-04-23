//
//  UIButton+CustomButton.h
//  5th task
//
//  Created by Владимир Курганов on 26.12.2022.
//

#import <UIKit/UIKit.h>

//MARK: - @interface MyCustomButton
@interface MyCustomButton: UIButton
-(id)initStartButton;
-(id)initEndButton;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
@end


