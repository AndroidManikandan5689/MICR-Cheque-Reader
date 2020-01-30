//
//  MicrReaderPlugin.h
//
//  @author Manikandan.K - 2020.
//

#import <Cordova/CDV.h>
@class claseAuxiliar;

@interface MicrReaderPlugin : CDVPlugin 

@property (nonatomic, copy) NSString* callbackID;

- (void) recognizeText:(CDVInvokedUrlCommand*)command;

@end
