package habbo.communication.sockets
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.utils.ByteArray;
	
	public class CommunicationSocket
	{
		//Variables
		private var socket:Socket;
		private var host:String;
		private var port:int;
		private var timer:Timer;
		private var startTime:int;
		
		public var eventOnTimeout:Array;
		public var eventOnConnect:Array;
		public var eventOnComplete:Array;
		public var eventOnClose:Array;
		public var eventOnData:Array;
		public var eventOnSecurityError:Array;
		public var eventOnIOError:Array;
		
		//Constructor
		public function CommunicationSocket(host:String, port:int)
		{
			//Set variables locally
			this.host = host;
			this.port = port;
			
			//Create socket
			this.socket = new Socket();
			
			//Create timer with timeout of 10000
			this.timer = new Timer(10000, 1);
			
			//Create event handler arrays
			this.eventOnTimeout = new Array();
			this.eventOnConnect = new Array();
			this.eventOnComplete = new Array();
			this.eventOnClose = new Array();
			this.eventOnData = new Array();
			this.eventOnSecurityError = new Array();
			this.eventOnIOError = new Array();
			
			//Register event handlers
			this.timer.addEventListener(TimerEvent.TIMER, this.onTimeout);
			this.socket.addEventListener(Event.CONNECT, this.onConnect);
			this.socket.addEventListener(Event.COMPLETE, this.onComplete);
			this.socket.addEventListener(Event.CLOSE, this.onClose);
			this.socket.addEventListener(ProgressEvent.SOCKET_DATA, this.onData);
			this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
			this.socket.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
		}
		
		//Methods
		public function connect():void
		{
			if(!this.socket.connected)
			{
				// Start the timeout timer
				this.startTime = getTimer();
				this.timer.start();
				
				//Connect to server
				this.socket.connect(this.host, this.port);
			}
		}
		
		public function disconnect():void
		{
			this.socket.close();
		}
		
		public function send(bytes:ByteArray):Boolean
		{
			if (this.socket.connected) {
				this.socket.writeBytes(bytes);
				this.socket.flush();
				return true;
			}
			else {
				return false;
			}
		}
		
		//Setters
		public function set timeout(timeout:int):void
		{
			this.timer.delay = timeout;
		}
		
		//Getters
		public function get timeout():int
		{
			return this.timer.delay;
		}
		
		//Events
		private function onTimeout(k:TimerEvent):void
		{
			this.timer.stop();
			for (var i:int = 0; i < eventOnTimeout.length; i++) {
				var f:Function = eventOnTimeout[i];
				f(k);
			}
		}
		
		private function onConnect(k:Event):void
		{
			this.timer.stop();
			for (var i:int = 0; i < eventOnConnect.length; i++) {
				var f:Function = eventOnConnect[i];
				f(k);
			}
		}
		
		private function onComplete(k:Event):void
		{
			this.timer.stop();
			for (var i:int = 0; i < eventOnComplete.length; i++) {
				var f:Function = eventOnComplete[i];
				f(k);
			}
		}
		
		private function onClose(k:Event):void
		{
			this.timer.stop();
			for (var i:int = 0; i < eventOnClose.length; i++) {
				var f:Function = eventOnClose[i];
				f(k);
			}
		}
		
		private function onData(k:ProgressEvent):void
		{
			this.timer.stop();
			for (var i:int = 0; i < eventOnData.length; i++) {
				var f:Function = eventOnData[i];
				f(k);
			}
		}
		
		private function onSecurityError(k:SecurityErrorEvent):void
		{
			this.timer.stop();
			for (var i:int = 0; i < eventOnSecurityError.length; i++) {
				var f:Function = eventOnSecurityError[i];
				f(k);
			}
		}
		
		private function onIOError(k:IOErrorEvent):void
		{
			this.timer.stop();
			for (var i:int = 0; i < eventOnIOError.length; i++) {
				var f:Function = eventOnIOError[i];
				f(k);
			}
		}
	}
}