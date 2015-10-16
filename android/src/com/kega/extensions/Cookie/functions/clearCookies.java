package com.kega.extensions.Cookie.functions;

import android.util.Log;
import android.webkit.CookieManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class clearCookies implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args ) {
		
		try {
			
			CookieManager.getInstance().removeAllCookie();
			
		} catch ( Exception exception ) {
			Log.w( "getCookies", exception );
		}
		
		return null;
	}

}