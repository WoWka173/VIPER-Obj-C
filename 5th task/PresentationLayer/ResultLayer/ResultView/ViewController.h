//
//  FinalViewController.swift
//  5th task
//
//  Created by Владимир Курганов on 11.11.2022.
//

#import <UIKit/UIKit.h>
#import "Presenter.h"


@protocol PresenterProtocol;

//MARK: - ViewControllerProtocol
@protocol ViewControllerProtocol <NSObject>

- (void)setLabelScore: (NSInteger *)score;
- (void)setLabelResult: (NSInteger *)score;

@end

//MARK: - @interface ViewController
@interface ViewController : UIViewController <ViewControllerProtocol>

@property (strong, nonatomic) id <PresenterProtocol> presenter;
@property (nonatomic) UILabel *scoreLabel;
@property (nonatomic) UILabel *resultLabel;
@property (nonatomic) UIButton *startAgainButton;
@property (nonatomic) UIButton *endGameButton;
- (void) setupScoreLabel;
- (void) addConfettiAnimation;
-(void)popToRoot;
-(void)popToBack;
-(id)initWithPresenter: (id<PresenterProtocol>) myPresentor;
- (void)setLabelScore: (NSInteger *)score;

@end
