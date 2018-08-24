package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.DisplayObject;

	public class HabboLoadingScreen extends Sprite
	{
		private var onStage:Boolean;
		
		public function HabboLoadingScreen()
		{
			if(stage)
				this.init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event=null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.RESIZE, this.onResize);
			onStage = true;
			
			var bg:Sprite = new Sprite();
			bg.name = "background";
			bg.graphics.clear();
			bg.graphics.beginFill(922908);
			bg.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			
			var _loc6_:Sprite = new Sprite();
			_loc6_.name = "fileLoadingBar";
			_loc6_.graphics.lineStyle(1,16777215,1,true);
			_loc6_.graphics.beginFill(2500143);
			_loc6_.graphics.drawRect(1,0,400 - 1,0);
			_loc6_.graphics.drawRect(400,1,0,25 - 1);
			_loc6_.graphics.drawRect(1,25,400 - 1,0);
			_loc6_.graphics.drawRect(0,1,0,25 - 1);
			_loc6_.graphics.endFill();
			
			displayElement(bg);
			displayElement(_loc6_);
		}
		
		private function onResize(e:Event):void 
		{
			var bg:DisplayObject = stage.getChildByName("background");
			bg.width = stage.stageWidth;
			bg.height = stage.stageHeight;
		}
		
		public function displayElement(displayable:DisplayObject):void
		{
			if(onStage)
				this.stage.addChild(displayable);
		}
	}
}