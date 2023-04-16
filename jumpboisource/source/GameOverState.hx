package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class GameOverState extends FlxState
{
	var text:FlxText;
	var restart:FlxButton;

	override public function create()
	{
		bgColor = FlxColor.RED;
		super.create();
		text = new FlxText(0, 0, 0, "You Died", 50);
		text.screenCenter();
		add(text);
		restart = new FlxButton(0, 0, "Restart", Restart);
		restart.x = ((FlxG.width / 2) - restart.width / 2);
		restart.y = (FlxG.height / 2) + text.height + 10;
		add(restart);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function Restart()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, () ->
		{
			FlxG.switchState(new PlayState());
		});
	}
}
