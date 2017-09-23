#import "OEControlCenterDisabler.h"
#import "headers.h"

static BOOL inhibited = NO;

@implementation OEControlCenterDisabler : NSObject
+ (void)setInhibited:(BOOL)value {
    inhibited = value;
}

+ (BOOL)isInhibited {
    return inhibited;
}
@end

%hook SBControlCenterController
- (void)beginPresentationWithTouchLocation:(CGPoint)location presentationBegunHandler:(void(^)())handler {
    if (inhibited) {
        return;
    }

    %orig;
}

- (void)_showControlCenterGestureBeganWithGestureRecognizer:(SBScreenEdgePanGestureRecognizer *)recognizer {
    if (inhibited) {
        return;
    }

    %orig;
}
%end
