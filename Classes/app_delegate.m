//
//  app_delegate.m
//  glitch_camera
//

#import "app_delegate.h"

@implementation app_delegate
@synthesize w, navigationController;

- (BOOL)application:(UIApplication*)application 
didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {    
    [w addSubview:navigationController.view];
    [w makeKeyAndVisible];
    return YES;
}

- (void)dealloc {
	[navigationController release];
	[w release];
	[super dealloc];
}


@end

