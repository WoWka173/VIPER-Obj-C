//
//  Presenter.m
//  testObject-C
//
//  Created by Владимир Курганов on 21.12.2022.
//

#import "Presenter.h"
#import "_th_task-Swift.h"


@interface Presenter()
@end

@implementation Presenter: NSObject

@synthesize view;
@synthesize router;
@synthesize interactor;

- (id)initWith:(id<MainRouterProtocol>)myRouter : (id<ResultInteractorProtocol>)myInteractor {
    self = [super init];
    interactor = myInteractor;
    router = myRouter;
    return self;
}
- (void)popToBack {
    [router popToBack];
}

- (void)popToRoot {
    [router popToRoot];
}

- (void)didloadData:(NSInteger *)score {
    [view setLabelScore: score];
    [view setLabelResult:score];
}

- (void)viewDidLoad {
    [interactor loadData];
}


@end


