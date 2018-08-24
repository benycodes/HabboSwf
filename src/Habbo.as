package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.StageScaleMode;
	import flash.display.StageQuality;
	import flash.display.StageAlign;
	import flash.external.ExternalInterface;
	
	import habbo.communication.sockets.CommunicationSocket;
	
	public class Habbo extends Sprite
	{
		private var gameSocket:CommunicationSocket;
		
		private var loadingScreen:HabboLoadingScreen;
		
		public function Habbo()
		{
			if(stage)
				this.stageReady();
			else
				this.addEventListener(Event.ADDED_TO_STAGE,this.stageReady);
		}
		
		private function stageReady():void {
			log("Stage ready");
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.LOW;
			stage.align = StageAlign.TOP_LEFT;
			showLoadingScreen();
		}
		
		private function startConnection():void {
			gameSocket = new CommunicationSocket("127.0.0.1", 30001);
			gameSocket.eventOnConnect.push(this.onConnect);
		}
		
		private function showLoadingScreen():void {
			this.loadingScreen = new HabboLoadingScreen();
			this.stage.addChild(this.loadingScreen);
		}
		
		private function onConnect(e:Event):void {
			trace("Connected!");
		}
		
		public static function log(k:String):void {
			try
			{
				if(ExternalInterface.available)
				{
					ExternalInterface.call("console.log", k);
				}
				return;
			}
			catch(e:Error)
			{
				return;
			}
		}
	}
}