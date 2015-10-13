package com.kega.extensions {

    import flash.events.Event;
	
    public class CookieEvent extends Event {
		
		public static const MESSAGE:String = "Message";
		
        public var params:Object;
        
        public function CookieEvent( type:String, params:Object = null, bubbles:Boolean = false, cancelable:Boolean = false ){
            super( type, bubbles, cancelable );
            this.params = params;
        }

    }
}