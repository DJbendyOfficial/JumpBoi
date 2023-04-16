package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	var title:FlxText;
	var play:FlxButton;
	var exit:FlxButton;

	override public function create()
	{
		bgColor = 0;
		super.create();
		title = new FlxText(0, 0, FlxG.width, "Jump Boi", 64);
		title.setFormat(null, 64, FlxColor.BLUE, FlxTextAlign.CENTER);
		add(title);

		play = new FlxButton(0, 0, "Play", clickPlay);
		play.x = (FlxG.width / 2) - (play.width / 2);
		play.y = (FlxG.height / 2);
		add(play);

		exit = new FlxButton(0, 0, "Exit", clickExit);
		exit.x = ((FlxG.width / 2) - exit.width / 2);
		exit.y = (FlxG.height / 2) + play.height + 10;
		add(exit);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		title.y++;
		if (title.y > FlxG.height)
			title.y = 0 - 64;
	}

	function clickPlay()
	{
		FlxG.switchState(new PlayState());
	}

	function clickExit()
	{
		Sys.exit(0);
	}
}
