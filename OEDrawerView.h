#import <UIKit/UIKit.h>

@interface OEDrawerView : UIScrollView
@property (strong, nonatomic) NSMutableArray *appArray;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)layoutApps;
- (NSMutableArray *)allAppsArray;
- (void)dismissView;
@end
