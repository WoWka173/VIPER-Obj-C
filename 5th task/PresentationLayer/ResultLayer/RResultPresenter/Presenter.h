//
//  Presenter.h
//  testObject-C
//
//  Created by Владимир Курганов on 21.12.2022.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "ResultInteractor.h"



@protocol ViewControllerProtocol;
@protocol MainRouterProtocol;
@protocol ResultInteractorProtocol;

@protocol PresenterProtocol 

@property (strong, nonatomic) id <MainRouterProtocol> router;
@property (nonatomic, weak) id <ViewControllerProtocol> view;
@property (strong, nonatomic) id <ResultInteractorProtocol> interactor;
-(void)popToRoot;
-(void)popToBack;
-(void)didloadData: (NSInteger *) score;
-(void)viewDidLoad;

@end


@interface Presenter : NSObject  <PresenterProtocol>

-(id)initWith: (id <MainRouterProtocol>) myRouter : (id<ResultInteractorProtocol>)myInteractor;

@end
