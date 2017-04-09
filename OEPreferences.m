#import "OEPreferences.h"
#import <Cephei/HBPreferences.h>

static NSString *const kEnabledKey = @"enabled";

@implementation OEPreferences

+ (instancetype)sharedSettings {
    static OEPreferences *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
  	if (self) {
    		_preferences = [HBPreferences preferencesForIdentifier:@"com.shade.oreo"];
    		[_preferences registerBool:&_enabled default:YES forKey:kEnabledKey];
  	}

  	return self;
}

+ (UIColor *)drawerColor {
    CFPreferencesAppSynchronize(kNoctisAppID);
    Boolean valid = NO;
    BOOL noctisEnabled = CFPreferencesGetAppBooleanValue(kNoctisEnabledKey, kNoctisAppID, &valid);
    BOOL useNoctis = noctisEnabled && valid;

    return useNoctis ? [UIColor blackColor] : [UIColor whiteColor];
}

@end
