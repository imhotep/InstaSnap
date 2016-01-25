//
//  ViewController.h
//  InstaSnap
//
//  Created by Anis Kadri on 1/22/16.
//  Copyright © 2016 Anis Kadri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Cordova/CDVViewController.h>
#import <UIKit/UIKit.h>
#import <Cordova/CDVViewController.h>
#import <AVFoundation/AVCaptureSession.h>
#import <AVFoundation/AVCaptureVideoPreviewLayer.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AVFoundation/AVCaptureInput.h>
#import <AVFoundation/AVCaptureOutput.h>
#import <AVFoundation/AVVideoSettings.h>
#import <ImageIO/ImageIO.h>


@interface ViewController : CDVViewController
@property(nonatomic, weak) IBOutlet UIView *vImagePreview;
@property (weak, nonatomic) IBOutlet UIButton *surpriseBtn;
@property(nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;
- (void)captureNow:(void (^)(NSData*))sendImageToJS;
@end

