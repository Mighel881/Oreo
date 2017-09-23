#import "OEDrawerController.h"
#import "OEPreferences.h"
#import "headers.h"

%hook SBUIController
- (BOOL)handleHomeButtonSinglePressUp {
    [[OEDrawerController sharedInstance] dismissView];
    return %orig;
}
%end

static inline void initializeTweak(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    [[OEDrawerController sharedInstance] view];
    SBScreenEdgePanGestureRecognizer *recognizer = [[%c(SBScreenEdgePanGestureRecognizer) alloc] initWithTarget:[OEDrawerController sharedInstance] action:@selector(gestureStateChanged:) type:SBSystemGestureTypeShowControlCenter];
    recognizer.edges = UIRectEdgeBottom;
    [[%c(SBSystemGestureManager) mainDisplayManager] addGestureRecognizer:recognizer withType:52];
}

%ctor {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, &initializeTweak, CFSTR("SBSpringBoardDidLaunchNotification"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    [OEPreferences sharedSettings];
}
