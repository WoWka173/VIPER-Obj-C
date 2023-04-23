//
//  NSObject+ResultInteractor.h
//  5th task
//
//  Created by Владимир Курганов on 26.12.2022.
//

#import <Foundation/Foundation.h>
#import "Presenter.h"


@protocol PresenterProtocol;
@protocol UserServiceProtocol;
@protocol ResultInteractorProtocol;

//MARK: - ResultInteractorProtocol
@protocol ResultInteractorProtocol <NSObject>

@property(weak, nonatomic) id <PresenterProtocol> presenter;
-(void)loadData;

@end

//MARK: - @interface ResultInteractor
@interface  ResultInteractor: NSObject <ResultInteractorProtocol>
@property id <UserServiceProtocol> userService;

@end


