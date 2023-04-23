//
//  ResultBuilder.h
//  5th task
//
//  Created by Владимир Курганов on 23.12.2022.
//

#import <UIKit/UIKit.h>
#import "Presenter.h"


@protocol MainRouterProtocol;
@protocol PresenterProtocol;
@protocol ViewControllerProtocol;
@protocol ResultInteractorProtocol;

//MARK: - ResultBuilderProtocol
@protocol ResultBuilderProtocol
-(UIViewController *)createResultModule:(id <MainRouterProtocol>)router : (id<ResultInteractorProtocol>)interactor;
@end

//MARK: - @interface ResultBuilder
@interface ResultBuilder : NSObject <ResultBuilderProtocol>

@end

