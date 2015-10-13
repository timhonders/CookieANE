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
				
				context = ExtensionContext.createExtensionContext('com.kega.extensions.Cookie', null);
				context.addEventListener(StatusEvent.STATUS, onStatus);
				if  (context == null) {
					trace('[Cookie] Error - Extension Context is null.');
				}
				
				_instance = this;
			} else {
				throw Error( '[Cookie] This is a singleton, use getInstance(), do not call the constructor directly.' );
			}
			
		}
		
		public static function getInstance():Cookie {
			return _instance ? _instance:new Cookie();
		}
		
		public static function clearAll():String { if (!_instance) { Core.getInstance(); } return _instance.clearAll(); }
		public function clearAll():String {
			var result:String = '';
			
			try {
				context.call('clearAll'); 
				result = '[Cookie] clearAll Succes';
			}catch(error:*){
				result = '[Cookie] clearAll Error: ' + error;
				
			}
			return result;
			
		}
		
		private function onStatus(event:StatusEvent):void {
			switch (event.code){

				default:
					dispatchEvent(new CoreEvent(CoreEvent.MESSAGE, {event:event}));
				break;

			}
			
		}
		
		public function dispose():void  {  
			context.dispose();  
		} 
	}
}