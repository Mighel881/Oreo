#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <SpringBoard/SpringBoard.h>
#import <SpringBoard/SBIconModel.h>
#import <SpringBoard/SBIconController.h>
#import <SpringBoard/SBApplicationIcon.h>
#import <SpringBoard/SBApplication.h>
#import <SpringBoard/SBMainDisplaySystemGestureManager.h>
#import <SpringBoard/SBScreenEdgePanGestureRecognizer.h>

#define kScreenWidth CGRectGetMaxX([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetMaxY([UIScreen mainScreen].bounds)


@interface UIApplication ()
- (BOOL)launchApplicationWithIdentifier:(id)identifier suspended:(BOOL)suspended;
@end

@interface SBHomeScreenWindow : UIWindow
@end

@interface SBUIController : NSObject
+ (id)sharedInstance;
- (id)window;
@end

@interface SBIconView : UIView
+ (CGSize)defaultIconSize;
@end

@interface SBIconModel (iOS81)
- (id)visibleIconIdentifiers;
- (id)applicationIconForBundleIdentifier:(id)arg1;
@end

@interface SBIconViewMap : NSObject
@property (nonatomic, readonly) SBIconModel *iconModel;
+ (SBIconViewMap *)switcherMap;
+ (SBIconViewMap *)homescreenMap;
- (SBIconView *)mappedIconViewForIcon:(SBApplicationIcon *)icon;
- (SBIconView *)_iconViewForIcon:(SBApplicationIcon *)icon;
- (SBIconView *)iconViewForIcon:(SBApplicationIcon *)icon;
@end

@interface SBIconController (iOS90)
@property (nonatomic,readonly) SBIconViewMap *homescreenIconViewMap;
+ (id)sharedInstance;
@end

@interface SBApplicationController : NSObject
+ (id)sharedInstance;
- (SBApplication*)applicationWithBundleIdentifier:(NSString*)identifier;
- (SBApplication*)applicationWithPid:(int)arg1;
@end
