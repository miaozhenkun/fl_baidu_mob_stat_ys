#import "BaiduMobStatPlugin.h"
#import "BaiduMobStat.h"

@implementation BaiduMobStatPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel
                                     methodChannelWithName:@"fl_baidu_mob_stat_ys"
                                     binaryMessenger:[registrar messenger]];
    BaiduMobStatPlugin *instance = [[BaiduMobStatPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:@"setApiKey"]) {
        [[BaiduMobStat defaultStat] startWithAppId:call.arguments];
        [BaiduMobStat defaultStat].platformType = 2;
        result(@(YES));
    } else if ([call.method isEqualToString:@"setAppVersionName"]) {
        [[BaiduMobStat defaultStat] setShortAppVersion:call.arguments];
        result(@(YES));
    } else if ([call.method isEqualToString:@"setAppChannel"]) {
        [[BaiduMobStat defaultStat] setChannelId:call.arguments];
        result(@(YES));
    } else if ([call.method isEqualToString:@"setDebug"]) {
        [BaiduMobStat defaultStat].enableDebugOn = [call.arguments boolValue];
        result(@(YES));
    } else if ([call.method isEqualToString:@"logEvent"]) {
        NSString *eventId = call.arguments[@"eventId"];
        NSDictionary *attributes = [self validArgument:call.arguments[@"attributes"]];
        [[BaiduMobStat defaultStat] logEvent:eventId attributes:attributes];
        result(@(YES));
    } else if ([call.method isEqualToString:@"logDurationEvent"]) {
        NSString *eventId = call.arguments[@"eventId"];
        NSString *eventLabel = call.arguments[@"label"];
        NSInteger duration = [call.arguments[@"duration"] integerValue];
        NSDictionary *attributes = [self validArgument:call.arguments[@"attributes"]];
        [[BaiduMobStat defaultStat] logEventWithDurationTime:eventId eventLabel:eventLabel durationTime:duration attributes:attributes];
        result(@(YES));
    } else if ([call.method isEqualToString:@"eventStart"]) {
        [[BaiduMobStat defaultStat] eventStart:call.arguments[@"eventId"] eventLabel:call.arguments[@"label"]];
        result(@(YES));
    } else if ([call.method isEqualToString:@"eventEnd"]) {
        NSString *eventId = call.arguments[@"eventId"];
        NSString *label = call.arguments[@"label"];
        NSDictionary *attributes = [self validArgument:call.arguments[@"attributes"]];
        [[BaiduMobStat defaultStat] eventEnd:eventId eventLabel:label attributes:attributes];
        result(@(YES));
    } else if ([call.method isEqualToString:@"pageStart"]) {
        [[BaiduMobStat defaultStat] pageviewStartWithName:call.arguments];
        result(@(YES));
    } else if ([call.method isEqualToString:@"pageEnd"]) {
        [[BaiduMobStat defaultStat] pageviewEndWithName:call.arguments];
        result(@(YES));
    } else if ([call.method isEqualToString:@"getDeviceCuId"]) {
        result([[BaiduMobStat defaultStat] getDeviceCuid]);
    } else if ([call.method isEqualToString:@"getTestDeviceId"]) {
        result([[BaiduMobStat defaultStat] getTestDeviceId]);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

// dart侧可选参数未传或传nil，oc侧接收到的是NSNull
- (id)validArgument:(id)argument {
    return [argument isEqual:[NSNull null]] ? nil : argument;
}

@end
