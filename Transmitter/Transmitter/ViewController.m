//
//  ViewController.m
//  Transmitter
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
    
    //config transmitter
    NSNumber *power = [NSNumber numberWithInt:-63];
    self.peripheraData = [self.beaconRegion peripheralDataWithMeasuredPower:power];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:queue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TransmitterDeleagete
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        _messageLabel.text = @"ON";
        [self.peripheralManager startAdvertising:self.peripheraData];
    }
    else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        _messageLabel.text = @"OFF";
        [self.peripheralManager stopAdvertising];
    }
}

@end
