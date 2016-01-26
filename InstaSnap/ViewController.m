//
//  ViewController.m
//  InstaSnap
//
//  Created by Anis Kadri on 1/22/16.
//  Copyright © 2016 Anis Kadri. All rights reserved.
//

#import "ViewController.h"
#import "MyCustomCameraPlugin.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // hide button
    self.surpriseBtn.hidden = YES;
    
    // creating capture session
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    session.sessionPreset = AVCaptureSessionPresetMedium;
    
    // creating a view layer to preview the capture using the session above
    CALayer *viewLayer = self.vImagePreview.layer;
    NSLog(@"viewLayer = %@", viewLayer);
    
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    
    // setting the session bounds
    captureVideoPreviewLayer.frame = self.vImagePreview.bounds;
    [captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    // adding the preview layer to the view
    [self.vImagePreview.layer addSublayer:captureVideoPreviewLayer];
    
    // setting the device (front vs back facing camera)
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if(!input) {
        NSLog(@"Error: trying to open camera: %@", error);
    }
    
    [session addInput:input];
    
    self.stillImageOutput =[[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = @{ AVVideoCodecKey: AVVideoCodecJPEG };
    [self.stillImageOutput setOutputSettings:outputSettings];
    [session addOutput:self.stillImageOutput];
    
    [session startRunning];
}
- (IBAction)surpriseMe:(id)sender {
    MyCustomCameraPlugin *plugin = [self.pluginObjects objectForKey:@"MyCustomCameraPlugin"];
    [plugin surprise];
}

- (void) captureNow:(void (^)(NSData*)) sendImageToJS {
    
    AVCaptureConnection *videoConnection = nil;
    for(AVCaptureConnection *connection in self.stillImageOutput.connections) {
        for(AVCaptureInputPort *port in [connection inputPorts]) {
            if([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if(videoConnection) { break; }
    }
    NSLog(@"Requesting capture from: %@", self.stillImageOutput);
    
    if([videoConnection isEnabled]) {
        [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
            CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
            if(exifAttachments) {
                NSLog(@"attachments: %@", exifAttachments);
            } else {
                NSLog(@"No attachments");
            }
            NSData* imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
            sendImageToJS(imageData);
        }];
    } else {
        NSLog(@"Video connection is disabled");
    }
    
    self.surpriseBtn.hidden = NO;
}

@end
