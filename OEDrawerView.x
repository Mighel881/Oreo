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
    }

    return self;
}

- (NSMutableArray*)allAppsArray {
    NSMutableArray *appArray = nil;
    if ([%c(SBIconViewMap) respondsToSelector:@selector(homescreenMap)]) {
        appArray = [[[[%c(SBIconViewMap) homescreenMap] iconModel] visibleIconIdentifiers] mutableCopy];
    } else {
        appArray = [[[[[%c(SBIconController) sharedInstance] homescreenIconViewMap] iconModel] visibleIconIdentifiers] mutableCopy];
    }

    [appArray sortUsingComparator:^(NSString* a, NSString* b) {
        NSString *a_ = [[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:a].displayName;
        NSString *b_ = [[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:b].displayName;
        return [a_ caseInsensitiveCompare:b_];
    }];
    return appArray;
}

- (SBIconView*)iconViewForBundleID:(NSString*)bundleIdentifier {
    SBApplicationIcon *icon = nil;
    SBIconView *iconView = nil;
    if ([%c(SBIconViewMap) respondsToSelector:@selector(homescreenMap)]) {
        icon = [[[%c(SBIconViewMap) homescreenMap] iconModel] applicationIconForBundleIdentifier:bundleIdentifier];
        iconView = [[%c(SBIconViewMap) homescreenMap] _iconViewForIcon:icon];
    } else {
        icon = [[[[%c(SBIconController) sharedInstance] homescreenIconViewMap] iconModel] applicationIconForBundleIdentifier:bundleIdentifier];
        iconView = [[[%c(SBIconController) sharedInstance] homescreenIconViewMap] _iconViewForIcon:icon];
    }
    if (!iconView || ![icon isKindOfClass:[%c(SBApplicationIcon) class]]) {
        return nil;
    }

    return iconView;
}

- (void)layoutApps {
    HBLogDebug(@"started layoutApps");
    CGSize fullSize = [%c(SBIconView) defaultIconSize];
    fullSize.height = fullSize.width;
    CGFloat padding = 20;

    NSInteger numIconsPerLine = 0;
    CGFloat tmpWidth = 10;
    while (tmpWidth + fullSize.width <= self.frame.size.width) {
        numIconsPerLine++;
        tmpWidth += fullSize.width + 20;
    }
    padding = (self.frame.size.width - (numIconsPerLine * fullSize.width)) / (numIconsPerLine + 1);

    CGSize contentSize = CGSizeMake(padding, 10);
    NSInteger horizontal = 0;

    for (NSString *str in self.appArray) {
        @autoreleasepool {
            SBIconView *iconView = [self iconViewForBundleID:str];
            iconView.frame = CGRectMake(contentSize.width, contentSize.height, iconView.frame.size.width, iconView.frame.size.height);
            contentSize.width += iconView.frame.size.width + padding;

            horizontal++;
            if (horizontal >= numIconsPerLine) {
                horizontal = 0;
                contentSize.width = padding;
                contentSize.height += iconView.frame.size.height + 10;
            }

            iconView.restorationIdentifier = str;
            UITapGestureRecognizer *iconViewTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(appViewItemTap:)];
            [iconView addGestureRecognizer:iconViewTapGestureRecognizer];
            [self addSubview:iconView];
            HBLogDebug(@"addSubview");
        }
    }
    contentSize.width = self.frame.size.width;
    contentSize.height += fullSize.height * 1.5;
    self.contentSize = contentSize;
    HBLogDebug(@"ended layoutApps");
}

- (void)dismissView {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.layer.cornerRadius = 10;
        CGPoint center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), kScreenHeight - 10);
        CGRect frame = CGRectMake(0, 0, 20, 20);
        self.frame = frame;
        self.center = center;
    } completion:nil];
}

- (void)appViewItemTap:(UITapGestureRecognizer*)recognizer {
    [self dismissView];
    [[UIApplication sharedApplication] launchApplicationWithIdentifier:recognizer.view.restorationIdentifier suspended:NO];
}

@end
