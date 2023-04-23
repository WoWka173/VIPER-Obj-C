//
//  NSObject+ResultInteractor.m
//  5th task
//
//  Created by Владимир Курганов on 26.12.2022.
//

#import "ResultInteractor.h"
#import "_th_task-Swift.h"

//MARK: - @interface ResultInteractor
@interface ResultInteractor()
@end

//MARK: - ResultInteractor
@implementation ResultInteractor

//MARK: - Properties
@synthesize presenter;
@synthesize userService;

//MARK: - Methods
- (void)loadData {
    self.userService = UserService.shared;
    NSInteger* score = [userService getUserScoreForKey:@"Score"];
    [presenter didloadData:score];
}

@end
