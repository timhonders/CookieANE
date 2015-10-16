package com.kega.extensions.Cookie.functions;

import java.net.CookieHandler;
import java.net.CookieStore;
import java.net.CookieManager;
import java.net.HttpCookie;
import java.net.URI;
import java.util.List;

import android.util.Log;
//import android.webkit.CookieManager;


//import android.webkit.CookieSyncManager;

import android.webkit.CookieSyncManager;

import com.adobe.fre.FREASErrorException;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREArray;
import com.adobe.fre.FREWrongThreadException;
import com.kega.extensions.Cookie.Extension;

public class getCookies implements FREFunction
{

	@Override
	public FREArray call( FREContext context, FREObject[] args ) {
		
		Extension.log("getCookie x");
		
		FREArray cookies_array = null;
		
		try {
			cookies_array = FREArray.newArray(0);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FREASErrorException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FREWrongThreadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//CookieSyncManager.getInstance().sync();
		
	
		try {
			
			android.webkit.CookieSyncManager.createInstance(context.getActivity().getApplicationContext());
			android.webkit.CookieManager.getInstance().setAcceptCookie(true);
			
		
			
			Extension.log("getCookie cookiemanage: " + Extension.cookiemanage);
			
			CookieStore store = Extension.cookiemanage.getCookieStore();
			Extension.log("getCookie store: " + store);
			List<HttpCookie> cookies = store.getCookies();
			for (HttpCookie cookie:cookies) {
				Extension.log("getCookie cookie");
			}
			
			//java.net.CookieStore rawCookieStore = ((java.net.CookieManager)CookieHandler.getDefault()).getCookieStore();
			
			/*
			context.getActivity().getApplication().getApplicationContext();
			
			android.webkit.CookieManager cookie_manager = android.webkit.CookieManager.getInstance();

			Extension.log("Cookie:" + cookie_manager.getCookie(".itnova.nl"));
			
			CookieManager manager = (java.net.CookieManager) CookieHandler.getDefault();
			
			CookieStore store = manager.getCookieStore();
			*/
			
			//Extension.log("getCookie qqq");
			//int count = 0;
			//URI url = new URI(".itnova.nl");
			//List<HttpCookie> cookies = rawCookieStore.get(url);
			//for (HttpCookie cookie : cookies) {
				//Extension.log("getCookie cookie");
				//Extension.log("Cookie:" + cookie.getName());
				//cookies_array.setLength(count+1);
				//cookies_array.setObjectAt(count, FREObject.newObject(cookie.getName()));
 				//count++;
			//}
			
			return cookies_array;
			
		} catch ( Exception exception ) {
			Extension.log( exception.toString() );
		}
		
		return null;
	}

}