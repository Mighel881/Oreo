#include "ORERootListController.h"

@implementation ORERootListController

+ (NSString *)hb_specifierPlist {
    return @"Root";
}

- (void)sendEmail {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:ziroalpha@gmail.com?subject=Oreo"]];
}

@end
