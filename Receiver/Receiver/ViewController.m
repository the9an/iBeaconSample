//
//  ViewController.m
//  Receiver
//
//  Created by NguyenTheQuan on 2014/08/05.
//  Copyright (c) 2014年 Home. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:uuidString];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:useridString];
    [self.beaconRegion setNotifyEntryStateOnDisplay:YES];
    [self.beaconRegion setNotifyOnEntry:YES];
    [self.beaconRegion setNotifyOnExit:YES];
    
    //config Receiver
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Receiver Deleagate
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    if ([region.identifier isEqualToString:useridString]) {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.alertBody = @"Welcome";
        localNotification.soundName = @"arrr.caf";
        [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
    }
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    if ([region.identifier isEqualToString:useridString]) {
        UILocalNotification * localNotification = [[UILocalNotification alloc] init];
        localNotification.alertBody = @"Bye Bye, See you soon ^^";
        localNotification.soundName = @"arrr.caf";
        [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
    }  
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if ([beacons count] == 0) {
        return;
    }
    
    NSString *message = @"";
    CLBeacon *beacon = [beacons firstObject];
    switch (beacon.proximity) {
        case CLProximityUnknown:
            
            break;
        case CLProximityFar:
            message = @"Please come to me";
            break;
        case CLProximityNear:
            message = @"Come here";
            break;
        case CLProximityImmediate:
            message =  @"Hello, My name is kid";
            break;
            
        default:
            break;
    }
    
    if (beacon.proximity != self.previousProximity) {
        [self speak:message];
        [_messageLabel setText:message];
        self.previousProximity = beacon.proximity;
    }
}


#pragma mark - Private
-(void)speak:(NSString*)message {
    AVSpeechSynthesizer * synth = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance * utterance = [[AVSpeechUtterance alloc] initWithString:message];
    [utterance setRate:AVSpeechUtteranceMaximumSpeechRate *.3f];
    [utterance setVolume:1.0f];
    [utterance setPitchMultiplier:0.7f];
    [utterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"en-IE"]];
    [synth speakUtterance:utterance];
}


@end
