package com.kega.extensions.Cookie;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.kega.extensions.Cookie.functions.*;

/*
 * This class specifies the mapping between the actionscript functions and the native classes.
 */

public class ExtensionContext extends FREContext
{
    @Override
    public void dispose() {
    }

    @Override
    public Map<String, FREFunction> getFunctions() {

        Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
        functionMap.put("getCookies", new getCookies());
        functionMap.put("clearCookies", new clearCookies());
        functionMap.put("setCookie", new setCookie());
        
        return functionMap;
    }
}
