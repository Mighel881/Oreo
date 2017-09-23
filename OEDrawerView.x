#import "OEDrawerView.h"
#import "OEPreferences.h"
#import "headers.h"

@implementation OEDrawerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [OEPreferences drawerColor];
        self.scrollEnabled = YES;
        self.layer.cornerRadius = 10;

        self.appArray = [self allAppsArray];

        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(noctisEnabled:) name:@"com.laughingquoll.noctis.enablenotification" object:nil];
        [center addObserver:self selector:@selector(noctisDisabled:) name:@"com.laughingquoll.noctis.disablenotification" object:nil];
    }

    return self;
}

- (void)noctisEnabled:(NSNotification *)note {
    self.backgroundColor = [UIColor blackColor];
}

- (void)noctisDisabled:(NSNotification *)note {
    self.backgroundColor = [UIColor whiteColor];
}

- (NSMutableArray *)allAppsArray {
    NSMutableArray *appArray = nil;
    if ([%c(SBIconViewMap) respondsToSelector:@selector(homescreenMap)]) {
        appArray = [[[%c(SBIconViewMap) homescreenMap].iconModel visibleIconIdentifiers] mutableCopy];
    } else {
        appArray = [[[[%c(SBIconController) sharedInstance] homescreenIconViewMap].iconModel visibleIconIdentifiers] mutableCopy];
    }

    [appArray sortUsingComparator:^(NSString* a, NSString* b) {
        NSString *a_ = [[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:a].displayName;
        NSString *b_ = [[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:b].displayName;
        return [a_ caseInsensitiveCompare:b_];
    }];
    return appArray;
}

- (SBIconView *)iconViewForBundleID:(NSString*)bundleIdentifier {
    SBApplicationIcon *icon = nil;
    SBIconView *iconView = nil;
    if ([%c(SBIconViewMap) respondsToSelector:@selector(homescreenMap)]) {
        icon = [[%c(SBIconViewMap) homescreenMap].iconModel applicationIconForBundleIdentifier:bundleIdentifier];
        iconView = [[%c(SBIconViewMap) homescreenMap] _iconViewForIcon:icon];
    } else {
        icon = [[[%c(SBIconController) sharedInstance] homescreenIconViewMap].iconModel applicationIconForBundleIdentifier:bundleIdentifier];
        iconView = [[[%c(SBIconController) sharedInstance] homescreenIconViewMap] _iconViewForIcon:icon];
    }
    if (!iconView || ![icon isKindOfClass:%c(SBApplicationIcon)]) {
        return nil;
    }

    return iconView;
}

- (void)layoutApps {
    CGSize fullSize = [%c(SBIconView) defaultIconSize];
    fullSize.height = fullSize.width;
    CGFloat padding = 20;

    NSInteger numIconsPerLine = 0;
    CGFloat tmpWidth = 10;
    while (tmpWidth + fullSize.width <= CGRectGetWidth(self.frame)) {
        numIconsPerLine++;
        tmpWidth += fullSize.width + 20;
    }
    padding = (CGRectGetWidth(self.frame) - (numIconsPerLine * fullSize.width)) / (numIconsPerLine + 1);

    CGSize contentSize = CGSizeMake(padding, 10);
    NSInteger horizontal = 0;

    for (NSString *app in self.appArray) {
        @autoreleasepool {
            HBLogDebug(@"App: %@", app);
            SBIconView *iconView = [self iconViewForBundleID:app];
            iconView.frame = CGRectMake(contentSize.width, contentSize.height, CGRectGetWidth(iconView.frame), CGRectGetHeight(iconView.frame));
            HBLogDebug(@"iconView.frame: %@", NSStringFromCGRect(iconView.frame));
            contentSize.width += CGRectGetWidth(iconView.frame) + padding;

            horizontal++;
            if (horizontal >= numIconsPerLine) {
                horizontal = 0;
                contentSize.width = padding;
                contentSize.height += CGRectGetWidth(iconView.frame) + 10;
            }

            iconView.restorationIdentifier = app;
            UITapGestureRecognizer *iconViewTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(appViewItemTap:)];
            [iconView addGestureRecognizer:iconViewTapGestureRecognizer];
            [self addSubview:iconView];
        }
    }
    contentSize.width = self.frame.size.width;
    contentSize.height += fullSize.height * 1.5;
    self.contentSize = contentSize;
}

- (void)dismissView {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.layer.cornerRadius = 10;
        CGPoint center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), kScreenHeight);
        CGRect frame = CGRectMake(0, 0, 20, 20);
        self.frame = frame;
        self.center = center;
    } completion:nil];
}

- (void)appViewItemTap:(UITapGestureRecognizer *)recognizer {
    [self dismissView];
    [(SpringBoard *)[UIApplication sharedApplication] launchApplicationWithIdentifier:recognizer.view.restorationIdentifier suspended:NO];
}

@end
