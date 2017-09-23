#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import <SpringBoard/SBApplication.h>
#import <SpringBoard/SBApplicationController.h>
#import <SpringBoard/SBApplicationIcon.h>
#import <SpringBoard/SBControlCenterController.h>
#import <SpringBoard/SBIconController.h>
#import <SpringBoard/SBIconModel.h>
#import <SpringBoard/SBMainDisplaySystemGestureManager.h>
#import <SpringBoard/SBScreenEdgePanGestureRecognizer.h>
#import <SpringBoard/SBUIController.h>
#import <SpringBoard/SpringBoard.h>
#import <UIKit/UIKit.h>

#define kScreenWidth CGRectGetMaxX([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetMaxY([UIScreen mainScreen].bounds)

@interface SBIconView : UIView
+ (CGSize)defaultIconSize;
@end

@interface SBIconModel (iOS81)
- (NSArray *)visibleIconIdentifiers;
- (SBApplicationIcon *)applicationIconForBundleIdentifier:(NSString *)identifier;
@end

@interface SBControlCenterController ()
- (void)presentAnimated:(BOOL)animated completion:(void(^)())completion;
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
@end

@interface UIImage (Private)
+ (instancetype)_applicationIconImageForBundleIdentifier:(NSString *)identifier format:(NSInteger)format;
+ (instancetype)_applicationIconImageForBundleIdentifier:(NSString *)identifier format:(NSInteger)format scale:(CGFloat)scale;
+ (instancetype)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
- (instancetype)_applicationIconImageForFormat:(NSInteger)format precomposed:(BOOL)precomposed;
@end
