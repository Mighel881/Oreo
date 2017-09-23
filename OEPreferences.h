#import <Cephei/HBPreferences.h>
#define kNoctisAppID CFSTR("com.laughingquoll.noctis")
#define kNoctisEnabledKey CFSTR("LQDDarkModeEnabled")

@interface OEPreferences : NSObject {
	HBPreferences *_preferences;
}
@property (readonly, nonatomic) BOOL enabled;
+ (instancetype)sharedSettings;
+ (UIColor *)drawerColor;
@end
