//
//  CookieANE.m
//  CookieANE
//
//  Created by Tim on 13/10/15.
//  Copyright © 2015 Tim. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FlashRuntimeExtensions.h"

FREObject helloWorld(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    @autoreleasepool {
        NSLog(@"Entering hellowWorld()");
    
        // Create Hello World String
        NSString *helloString = @"Hello World!";
    
        // Convert Obj-C string to C UTF8String
        const char *str = [helloString UTF8String];
    
        // Prepare for AS3
        FREObject retStr;
        FRENewObjectFromUTF8(strlen(str)+1, (const uint8_t*)str, &retStr);
    
        // Return data back to ActionScript
        return retStr;
    }
}

//------------------------------------
//
// Required Methods.
//
//------------------------------------


// The context initializer is called when the runtime creates the extension context instance.
void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {
    
    uint32_t function_count = 1;
    *numFunctionsToTest = function_count;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * function_count);
    func[0].name = (const uint8_t*) "helloWorld";
    func[0].functionData = NULL;
    func[0].function = &helloWorld;
    

    
    *functionsToSet = func;
    
    // Init our Obj-C extension
    //extension = [[IOSExtension alloc] init];
    //[extension release];
    
}


// The context finalizer is called when the extension's ActionScript code
// calls the ExtensionContext instance's dispose() method.
// If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls
// ContextFinalizer().

void ContextFinalizer(FREContext ctx) {
    
    NSLog(@"Entering ContextFinalizer()");
    
    // Nothing to clean up.
    
    NSLog(@"Exiting ContextFinalizer()");
    
    // dealloc our Obj-C extension instance
    //[extension dealloc];
    
    return;
}


// The extension initializer is called the first time the ActionScript side of the extension
// calls ExtensionContext.createExtensionContext() for any context.

void ExtentionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet,FREContextFinalizer* ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtInitializer()");
    
    *extDataToSet = NULL;
    *ctxInitializerToSet = &ContextInitializer;
    *ctxFinalizerToSet = &ContextFinalizer;
    
    NSLog(@"Exiting ExtInitializer()");
}


// The extension finalizer is called when the runtime unloads the extension. However, it is not always called.

void ExtentionFinalizer(void* extData) {
    
    NSLog(@"Entering ExtFinalizer()");
    
    // Nothing to clean up.
    
    NSLog(@"Exiting ExtFinalizer()");
    return;
}