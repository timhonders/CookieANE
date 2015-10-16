package com.kega.extensions {
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	public class Cookie extends EventDispatcher {
		
		private static var _instance:Cookie = null;
		
		public var context:ExtensionContext = null;

		public function Cookie() {
			
			if (!_instance) {
				
				if (this.isSupported){
					context = ExtensionContext.createExtensionContext('com.kega.extensions.Cookie', null);
					context.addEventListener(StatusEvent.STATUS, onStatus);
					if  (context == null) {
						trace('[Cookie] Error - Extension Context is null.');
					}
				}
				
				_instance = this;
				
			} else {
				throw Error( '[Cookie] This is a singleton, use getInstance(), do not call the constructor directly.' );
			}
			
		}
		
		public function get isSupported():Boolean{
			var result:Boolean = (Capabilities.manufacturer.search('iOS') > -1 || Capabilities.manufacturer.search('Android') > -1);
			return result;
		}
		
		public static function getInstance():Cookie {
			return _instance ? _instance:new Cookie();
		}
		
		
		public static function getCookies():* { if (!_instance) { Cookie.getInstance(); } return _instance.getCookies(); }
		public function getCookies():* {
			var result:*;
			
			try {
				if (Capabilities.manufacturer.search('iOS') > -1){
		
					var cookies:Array = context.call('getCookies') as Array; 
					result = new Object();
					for each (var cookie:Object in cookies) {
						result[cookie.name] = cookie.value;
					}
				}else if (Capabilities.manufacturer.search('Android') > -1){
					context.call('getCookies');
					result = new Object();
				}else{
					result = 'Windows not supported';
				}
			}catch(error:*){
				result = '[Cookie] getCookies Error: ' + error + ' ' + context;
				
			}
			return result;
			
		}	
		
		public static function clearCookies():String { if (!_instance) { Cookie.getInstance(); } return _instance.clearCookies(); }
		public function clearCookies():String {
			var result:String = '';
			
			try {
				if (Capabilities.manufacturer.search('iOS') > -1){
					result = context.call('clearCookies') as String; 
				}else{
					result = 'Windows not supported';
				}
			}catch(error:*){
				result = '[Cookie] clearCookies Error: ' + error + ' ' + context;
				
			}
			return result;
			
		}	
		
		public static function setCookie(url:String, name:String, value:String):String { if (!_instance) { Cookie.getInstance(); } return _instance.setCookie(url, name, value); }
		public function setCookie(url:String, name:String, value:String):String {
			var result:String = '';
			
			try {
				if (Capabilities.manufacturer.search('iOS') > -1){
					context.call('setCookie', url, name, value); 
				}else  if (Capabilities.manufacturer.search('Android') > -1){
					value = name +'='+value;
					context.call('setCookie', url, value); 
				}else{
					result = 'Windows not supported';
				}
			}catch(error:*){
				result = '[Cookie] hello Error: ' + error + ' ' + context;
				
			}
			return result;
			
		}		
		
		private function onStatus(event:StatusEvent):void {
			switch (event.code){

				default:
					dispatchEvent(new CookieEvent(CookieEvent.MESSAGE, {event:event}));
				break;

			}
			
		}
		
		public function dispose():void  {  
			context.dispose();  
		} 
	}
}