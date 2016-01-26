//
//  MyCustomCameraPlugin.h
//  InstaSnap
//
//  Created by Anis Kadri on 1/25/16.
//  Copyright © 2016 Anis Kadri. All rights reserved.
//

#import <Cordova/CDVPlugin.h>

@interface MyCustomCameraPlugin : CDVPlugin
-(void)captureNow:(CDVInvokedUrlCommand*) command;
-(void)surprise;
@end
