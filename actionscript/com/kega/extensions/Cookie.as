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
		
/*		public static function clearAll():String { if (!_instance) { Cookie.getInstance(); } return _instance.clearAll(); }
		public function clearAll():String {
			var result:String = '';
			
			try {
				
				if (Capabilities.manufacturer.search('iOS') > -1){
					context.call('helloWorld'); 
				}
				
				result = '[Cookie] clearAll Succes';
			}catch(error:*){
				result = '[Cookie] clearAll Error: ' + error;
				
			}
			return result;
			
		}*/
		
		
		public static function hello():String { if (!_instance) { Cookie.getInstance(); } return _instance.hello(); }
		public function hello():String {
			var result:String = '';
			
			try {
				if (Capabilities.manufacturer.search('iOS') > -1){
					result = context.call('helloWorld') as String; 
				}else{
					result = 'Windows not supported';
				}
			}catch(error:*){
				result = '[Cookie] hello Error: ' + error + ' ' + context;
				
			}
			return result;
			
		}
		
		public static function setCookie():String { if (!_instance) { Cookie.getInstance(); } return _instance.setCookie(); }
		public function setCookie():String {
			var result:String = '';
			
			try {
				if (Capabilities.manufacturer.search('iOS') > -1){
					result = context.call('set') as String; 
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