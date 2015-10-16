package com.kega.extensions.Cookie.functions;

import android.util.Log;
import android.webkit.CookieManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class setCookie implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args ) {
		
		try {
			
			String url = args[0].getAsString();
			String value = args[1].getAsString();
			
			CookieManager.getInstance().setCookie(url, value);
			
		} catch ( Exception exception ) {
			Log.w( "getCookies", exception );
		}
		
		return null;
	}

}