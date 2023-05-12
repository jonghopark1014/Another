//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_blue_plus/FlutterBluePlusPlugin.h>)
#import <flutter_blue_plus/FlutterBluePlusPlugin.h>
#else
@import flutter_blue_plus;
#endif

#if __has_include(<flutter_watch_os_connectivity/FlutterWatchOsConnectivityPlugin.h>)
#import <flutter_watch_os_connectivity/FlutterWatchOsConnectivityPlugin.h>
#else
@import flutter_watch_os_connectivity;
#endif

#if __has_include(<is_wear/IsWearPlugin.h>)
#import <is_wear/IsWearPlugin.h>
#else
@import is_wear;
#endif

#if __has_include(<watch_connectivity/WatchConnectivityPlugin.h>)
#import <watch_connectivity/WatchConnectivityPlugin.h>
#else
@import watch_connectivity;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterBluePlusPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterBluePlusPlugin"]];
  [FlutterWatchOsConnectivityPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterWatchOsConnectivityPlugin"]];
  [IsWearPlugin registerWithRegistrar:[registry registrarForPlugin:@"IsWearPlugin"]];
  [WatchConnectivityPlugin registerWithRegistrar:[registry registrarForPlugin:@"WatchConnectivityPlugin"]];
}

@end
