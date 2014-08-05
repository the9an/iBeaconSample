//
//  ViewController.h
//  Receiver
//
//  Created by NguyenTheQuan on 2014/08/05.
//  Copyright (c) 2014年 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#include <CoreLocation/CoreLocation.h>

static NSString *uuidString = @"26CC2660-E5D3-4AEB-9ED6-F4941402E0A5"; //cmd: $uuidgen
static NSString *useridString = @"quankid";

@interface ViewController : UIViewController<CLLocationManagerDelegate>
{
    IBOutlet UILabel *_messageLabel;
}

@property (nonatomic, retain) CLBeaconRegion *beaconRegion;
@property (nonatomic, retain) CBPeripheralManager *peripheralManager;
@property (nonatomic, retain) NSMutableDictionary *peripheraData;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic) CLProximity previousProximity;

@end
