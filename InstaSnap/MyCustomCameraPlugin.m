//
//  MyCustomCameraPlugin.m
//  InstaSnap
//
//  Created by Anis Kadri on 1/25/16.
//  Copyright © 2016 Anis Kadri. All rights reserved.
//

#import "MyCustomCameraPlugin.h"
#import "ViewController.h"

@implementation MyCustomCameraPlugin
-(void)captureNow:(CDVInvokedUrlCommand *)command {
    NSLog(@"Capturing now...");
    ViewController* mvc = (ViewController*)[self viewController];
    [mvc captureNow:^(NSData* imageData) {
        NSLog(@"Sending imageData back to Javascript");
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}
-(void)surprise {
    [self.commandDelegate evalJs:@"app.surprise();"];
}
@end
