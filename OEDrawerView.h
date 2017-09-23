#import <UIKit/UIKit.h>

@interface OEDrawerView : UIScrollView
@property (copy, nonatomic) NSArray *appsArray;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)layoutApps;
- (void)dismissView;
@end
