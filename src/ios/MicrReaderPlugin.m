/********* MicrReaderPlugin.m Cordova Plugin Implementation *******/
/*
#import <Cordova/CDV.h>

@interface MicrReaderPlugin : CDVPlugin {
  // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
@end

@implementation MicrReaderPlugin

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
*/


//
//  MicrReaderPlugin.m
//
//  @author Manikandan.K - 2020.
//

#import "MicrReaderPlugin.h"
#import "claseAuxiliar.h"

@implementation MicrReaderPlugin
@synthesize callbackID;





- (void) recognizeText:(CDVInvokedUrlCommand*)command { //get the callback id 
    NSArray *arguments = command.arguments;
    
    NSString *language = [arguments objectAtIndex:0];
    NSLog(@"%s:%d language=%@", __func__, __LINE__, language);
    NSString *imagedata = [arguments objectAtIndex:1];


    self.callbackID = command.callbackId;

    NSData *data;

    if ([NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)]) {
        data = [[NSData alloc] initWithBase64EncodedString:imagedata options:kNilOptions];  // iOS 7+
    } else {
        data = [[NSData alloc] initWithBase64Encoding:imagedata];                           // pre iOS7
    }


    claseAuxiliar *cA = [[claseAuxiliar alloc]init];

    
    UIImage *Realimage = [[UIImage alloc] initWithData:data];

    
    NSString *text = [cA ocrImage:Realimage withLanguage:language];

    [self performSelectorOnMainThread:@selector(ocrProcessingFinished:)
                           withObject:text
                        waitUntilDone:NO];
    
}



- (void)ocrProcessingFinished:(NSString *)result
{


    
    
    // Create Plugin Result 
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString: result ];
    
    
    // Checking if the string received is HelloWorld or not
    
    if (result == nil
        || ([result respondsToSelector:@selector(length)]
            && [(NSData *)result length] == 0)
        || ([result respondsToSelector:@selector(count)]
            && [(NSArray *)result count] == 0))
        
    {
        // Call  the Failure Javascript function
        
        [self writeJavascript: [pluginResult toErrorCallbackString:self.callbackID]];
        
                
    } else
        
    {    
        
        // Call  the Success Javascript function
        
        [self writeJavascript: [pluginResult toSuccessCallbackString:self.callbackID]];

        
    }
}

@end
