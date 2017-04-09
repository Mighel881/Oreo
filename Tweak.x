#import "OEDrawerController.h"
#import "headers.h"

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)application {
    %orig;

    [[OEDrawerController sharedInstance] view];
    UIScreenEdgePanGestureRecognizer *screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:[OEDrawerController sharedInstance] action:@selector(gestureStateChanged:)];
    screenEdgePan.edges = UIRectEdgeBottom;
    [[%c(FBSystemGestureManager) sharedInstance] addGestureRecognizer:screenEdgePan toDisplay:[%c(FBDisplayManager) mainDisplay]];
}
%end

%hook SBUIController
- (BOOL)handleHomeButtonSinglePressUp {
    [[OEDrawerController sharedInstance] dismissView];
    return %orig;
}
%end
