package com.kega.extensions.Cookie;

import java.net.CookieHandler;
import java.net.CookieManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

/*
 * Initialization and finalization class of native extension.
 */
public class Extension implements FREExtension
{
	public static ExtensionContext context;
	public static CookieManager cookiemanage;
	
    public FREContext createContext(String extId) {
    	context = new ExtensionContext();
    	return context;
    }

    @Override
    public void dispose() {
    	context = null;
    }

    /*
      * Extension initialization.
      */
    public void initialize( ) {
    	
    	Extension.cookiemanage = new CookieManager();
		CookieHandler.setDefault(Extension.cookiemanage);
		
    }
    
    
    public static void log(String message){
    	
		context.dispatchStatusEventAsync("LOGGING", message);
		
	}
}
