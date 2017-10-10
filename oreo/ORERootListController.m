#include "ORERootListController.h"

@implementation ORERootListController

+ (NSString *)hb_specifierPlist {
    return @"Root";
}

- (void)viewDidLoad {
  	[super viewDidLoad];

  	CGRect frame = CGRectMake(0, 0, self.table.bounds.size.width, 127);

  	UIImage *headerImage = [UIImage imageNamed:@"OreoHeader" inBundle:self.bundle];

  	UIImageView *headerView = [[UIImageView alloc] initWithFrame:frame];
  	headerView.image = headerImage;
  	headerView.backgroundColor = [UIColor blackColor];
  	headerView.contentMode = UIViewContentModeScaleAspectFit;
  	headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

  	self.table.tableHeaderView = headerView;
}

- (void)viewDidLayoutSubviews {
  	[super viewDidLayoutSubviews];

  	CGRect wrapperFrame = ((UIView *)self.table.subviews[0]).frame;
  	CGRect frame = CGRectMake(wrapperFrame.origin.x, self.table.tableHeaderView.frame.origin.y, wrapperFrame.size.width, self.table.tableHeaderView.frame.size.height);

  	self.table.tableHeaderView.frame = frame;
}

@end
