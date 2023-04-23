//
//  ResultView.m
//  5th task
//
//  Created by Владимир Курганов on 21.12.2022.
//

#import "ViewController.h"
#import "MyCustomButton.h"
#import "_th_task-Swift.h"

//MARK: - @interface ViewController
@interface ViewController()
- (void) addConfettiAnimation;
- (id) generateEmitterCells;
- (UIColor *) getNextColor;
- (UIImage *) getNextImage;
@end

//MARK: - @implementation ViewController
@implementation ViewController

//MARK: - Properties
@synthesize presenter;
@synthesize scoreLabel;
@synthesize resultLabel;
@synthesize startAgainButton;
@synthesize endGameButton;

- (UILabel *)scoreLabel {
    scoreLabel = [[UILabel alloc] init];
    scoreLabel.text = @"";
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.textColor = UIColor.blackColor;
    [scoreLabel setFont:[UIFont fontWithName: @"Rubik-Medium" size: 32]];
    return  scoreLabel;
}

- (UILabel *)resultLabel {
    resultLabel = [[UILabel alloc] init];
    resultLabel.text = @"";
    resultLabel.textAlignment = NSTextAlignmentCenter;
    resultLabel.textColor = UIColor.blackColor;
    [resultLabel setFont:[UIFont fontWithName: @"Rubik-Regular" size: 28]];
    return resultLabel;
}

- (UIButton *)startAgainButton {
    startAgainButton = [[MyCustomButton alloc] initStartButton];
    [startAgainButton addTarget:self action:@selector(popToBack) forControlEvents:UIControlEventTouchUpInside];
    return startAgainButton;
}

- (UIButton *)endGameButton {
    endGameButton = [[MyCustomButton alloc] initEndButton];
    [endGameButton addTarget:self action:@selector(popToRoot) forControlEvents: UIControlEventTouchUpInside];
    return endGameButton;
}

//MARK: - Init
- (id)initWithPresenter:(id <PresenterProtocol>) myPresentor {
    self = [super init];
    presenter = myPresentor;
    return self;
}

//MARK: - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.973 green:1 blue:0.894 alpha:1];
    self.presenter.view = self;
    [self setupView];
    [presenter viewDidLoad];
    [self addConfettiAnimation];
}

//MARK: - Methods
- (void)setLabelScore: (NSInteger *)score {
    scoreLabel.text = [NSString stringWithFormat:@"%i", score];
}

- (void)setLabelResult:(NSInteger *)score {
    int scr = score;
    if (scr >= 0 && scr <= 3) {
        resultLabel.text = @"ПЛОХО!";
    }
    if (scr >= 3 && scr <= 7 ){
        resultLabel.text = @"ХОРОШО!";
    }
    if (scr >= 7 && scr <= 10) {
        resultLabel.text = @"ОТЛИЧНО!";
    }
}

- (void)popToBack {
    [presenter popToBack];
}

-(void)popToRoot {
    [presenter popToRoot];
}

- (void)setupView {
    [self scoreLabel];
    [self setupScoreLabel];
    [self resultLabel];
    [self setupResultLabel];
    [self setupStartAgainButton];
    [self setupEndGameButton];
}

- (void)setupEndGameButton {
    [self.view addSubview: self.endGameButton];
    endGameButton.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints: @[
        [endGameButton.widthAnchor constraintEqualToConstant: 335],
        [endGameButton.heightAnchor constraintEqualToConstant: 48],
        [endGameButton.topAnchor constraintEqualToAnchor: startAgainButton.bottomAnchor constant: 20],
        [endGameButton.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor ]
    ]];
}

- (void)setupStartAgainButton {
    [self.view addSubview: self.startAgainButton];
    startAgainButton.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints: @[
        [startAgainButton.widthAnchor constraintEqualToConstant: 335],
        [startAgainButton.heightAnchor constraintEqualToConstant: 48],
        [startAgainButton.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor constant: -98],
        [startAgainButton.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor ]
    ]];
}

- (void)setupScoreLabel {
    [self.view addSubview: scoreLabel];
    scoreLabel.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints: @[
        [scoreLabel.topAnchor constraintEqualToAnchor: self.view.topAnchor constant: 252],
        [scoreLabel.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor ]
    ]];
}

- (void)setupResultLabel {
    [self.view addSubview: resultLabel];
    resultLabel.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints: @[
        [resultLabel.topAnchor constraintEqualToAnchor: scoreLabel.bottomAnchor constant: 20],
        [resultLabel.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor]
    ]];
}

//MARK: - @interface extension
- (void)addConfettiAnimation {
    CAEmitterLayer *emitter = [[CAEmitterLayer alloc] init];
    emitter.emitterPosition = CGPointMake(self.view.center.x, -50);
    emitter.emitterCells = [self generateEmitterCells];
    emitter.frame = self.view.bounds;
    [self.view.layer addSublayer: emitter];
}

- (id)generateEmitterCells {
    NSMutableArray * cells = [[NSMutableArray alloc] init];
   float score = ([UserService.shared getUserScoreForKey:@"Score"]) / 10.0;
    NSLog(@"%f", score);
    for (int i = 0; i < 15; i++) {
        CAEmitterCell *cell = [[CAEmitterCell alloc] init];
        cell.birthRate = score;
        cell.lifetime = 20;
        cell.lifetimeRange = 0;
        cell.velocity = 100;
        cell.velocityRange = 100;
        cell.emissionLongitude = M_PI;
        cell.emissionRange = M_PI * 2;
        cell.spin = 3;
        cell.spinRange = 0;
        cell.color = [self getNextColor].CGColor;
        cell.contents = (__bridge id _Nullable)([self getNextImage].CGImage);
        cell.scaleRange = 0;
        cell.scale = 1.5;
        [cells addObject: cell];
    }
    return cells;
}

- (UIColor *)getNextColor {
    NSArray *colors = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor greenColor], [UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor greenColor]];
    NSUInteger randomColor = arc4random() % [colors count];
    return colors[randomColor];
}

- (UIImage *)getNextImage {
    NSArray<UIImage *> *images = @[[UIImage imageNamed:@"Line1"],[UIImage imageNamed:@"Line2"],[UIImage imageNamed:@"Line3"]];
    NSUInteger randomImage = arc4random() % [images count];
    return images[randomImage];
}

@end

