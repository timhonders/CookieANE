//
//  CookieANE.m
//  CookieANE
//
//  Created by Tim on 13/10/15.
//  Copyright © 2015 Tim. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FlashRuntimeExtensions.h"

FREObject getCookies(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    
    FREObject cookies_array = NULL;
    FRENewObject((const uint8_t*)"Array", 0, NULL, &cookies_array, nil);
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray *allCookies = [storage cookies];
    int32_t i = 0;
    for ( NSHTTPCookie *cookie in allCookies) {

        FREObject c;
        FREObject name;
        FRENewObjectFromUTF8(StrLength([cookie.name UTF8String])+1, (const uint8_t*)[cookie.name UTF8String], &name);
        
        FREObject value;
        FRENewObjectFromUTF8(StrLength([cookie.value UTF8String])+1, (const uint8_t*)[cookie.value UTF8String], &value);
        
        FRENewObject((const uint8_t*)"Object", 0, NULL, &c,NULL);
        FRESetObjectProperty(c, (const uint8_t*)"name", name, NULL);
        FRESetObjectProperty(c, (const uint8_t*)"value", value, NULL);
        
        FRESetArrayElementAt(cookies_array, i, c);
        i++;
    }
    
    return cookies_array;
}

FREObject clearCookies(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray *allCookies = [storage cookies];
    
    for ( NSHTTPCookie *cookie in allCookies) {
        FREDispatchStatusEventAsync(ctx, (uint8_t*)[cookie.name UTF8String], (uint8_t*)[cookie.value UTF8String]);
        [storage deleteCookie:cookie];
    }
    
    
    return NULL;
}


FREObject setCookie(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    
    FREDispatchStatusEventAsync(ctx, (uint8_t*)[@"setCookie" UTF8String], (uint8_t*)[@"test" UTF8String]);
                                
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    NSHTTPCookie *cookie;
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"testCookie" forKey:NSHTTPCookieName];
    [cookieProperties setObject:[NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]] forKey:NSHTTPCookieValue];
    [cookieProperties setObject:@"tim1.itnova.nl" forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"tim1.itnova.nl" forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    
    // set expiration to one month from now
    [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
    
    cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    return NULL;
}


//------------------------------------
//
// Required Methods.
//
//------------------------------------


// The context initializer is called when the runtime creates the extension context instance.
void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {
    
    uint32_t function_count = 3;
    *numFunctionsToTest = function_count;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * function_count);
    func[0].name = (const uint8_t*) "getCookies";
    func[0].functionData = NULL;
    func[0].function = &getCookies;
    
    func[1].name = (const uint8_t*) "setCookie";
    func[1].functionData = NULL;
    func[1].function = &setCookie;
    
    func[2].name = (const uint8_t*) "clearCookies";
    func[2].functionData = NULL;
    func[2].function = &clearCookies;

    
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