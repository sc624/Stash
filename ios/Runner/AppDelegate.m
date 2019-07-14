#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  [GMSServices provideAPIKey: @"AIzaSyBDQvcPLln8Lr3yN-Kkd4cU0tpLOS22Q8w"];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
