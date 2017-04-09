#import "OEControlCenterDisabler.h"
#import <UIKit/UIKit.h>

BOOL inhbited = NO;

@implementation OEControlCenterDisabler : NSObject
+ (void)setInhibited:(BOOL)value {
    inhbited = value;
}

+ (BOOL)isInhibited {
    return inhbited;
}
@end

%hook SBControlCenterController
- (void)presentAnimated:(BOOL)arg1 completion:(id)arg2 {
  	if (inhbited) {
  		  return;
  	}
  	%orig;
}
%end
