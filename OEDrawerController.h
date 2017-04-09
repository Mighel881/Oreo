#import <UIKit/UIKit.h>
#import "OEDrawerView.h"

@interface OEDrawerController : UIViewController
+ (instancetype)sharedInstance;
- (void)dismissView;
@end
