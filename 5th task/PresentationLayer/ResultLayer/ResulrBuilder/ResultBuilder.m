//
//  ResultBuilder.m
//  5th task
//
//  Created by Владимир Курганов on 23.12.2022.
//

#import "ResultBuilder.h"
#import "_th_task-Swift.h"

//MARK: - @interface ResultBuilder
@interface ResultBuilder()
@end

//MARK: - ResultBuilder
@implementation ResultBuilder

- (UIViewController *)createResultModule:(id<MainRouterProtocol>) router :
                                            (id<ResultInteractorProtocol>)interactor {
    
    id <PresenterProtocol> presenter = [[Presenter alloc] initWith:router :interactor];
    id <ViewControllerProtocol> view = [[ViewController alloc] initWithPresenter: presenter];
    interactor.presenter = presenter;
    return view;
    
}

@end
