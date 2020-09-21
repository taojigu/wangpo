#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "FlutterBoost.h"
#import "PlatformRouterImp.h"
#import "GateViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    PlatformRouterImp *router = [PlatformRouterImp new];
    [FlutterBoostPlugin.sharedInstance startFlutterWithPlatform:router
                                                        onStart:^(FlutterEngine *engine) {
                                                            
                                                        }];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    GateViewController *gvc = [sb instantiateViewControllerWithIdentifier:@"GateViewController"];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:gvc];
    router.navigationController = navi;
    self.window.rootViewController = navi;
    
  //[GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
