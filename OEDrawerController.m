#import "OEDrawerController.h"
#import "OEControlCenterDisabler.h"
#import "OEPreferences.h"
#import "headers.h"

@implementation OEDrawerController

+ (instancetype)sharedInstance {
    static OEDrawerController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)loadView {
    OEDrawerView *drawerView = [[OEDrawerView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.view = drawerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDrawer];
}

- (void)setupDrawer {
    self.view.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), kScreenHeight - 10);

    SBHomeScreenWindow *homescreenWindow = [[objc_getClass("SBUIController") sharedInstance] window];
    [homescreenWindow addSubview:self.view];
}

- (void)animateDrawerIn {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.layer.cornerRadius = 0;
        CGPoint center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        CGRect frame = CGRectMake(0, 0, 310, 502);
        self.view.frame = frame;
        self.view.center = center;
    } completion:^(BOOL complete) {
        if (complete) {
          [(OEDrawerView*)self.view layoutApps];
          [OEControlCenterDisabler setInhibited:NO];
        }
    }];
}

- (void)dismissView {
    [(OEDrawerView*)self.view dismissView];
}

- (void)gestureStateChanged:(UIGestureRecognizer*)recognizer {
    if (![OEPreferences sharedSettings].enabled || recognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    CGFloat x = touchLocation.x;
    if (x < kScreenWidth/3 || x > kScreenWidth/1.5) {
        HBLogDebug(@"x = %f, not within bounds ", x);
        return;
    }

    [OEControlCenterDisabler setInhibited:YES];
    [self animateDrawerIn];
}

@end
