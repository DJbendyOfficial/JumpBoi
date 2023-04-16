package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	static inline var SPEED:Float = 100;

	var newAngle:Float = 0;
	var number = Std.random(3);

	var player:FlxSprite;
	var enemy:FlxSprite;
	var platform1:FlxSprite;
	var platform2:FlxSprite;
	var platform3:FlxSprite;

	override public function create()
	{
		bgColor = 0;
		super.create();
		player = new FlxSprite();
		enemy = new FlxSprite(-10, 0);
		platform1 = new FlxSprite(0, 0);
		platform2 = new FlxSprite(0, 0);
		platform3 = new FlxSprite(0, 0);
		player.makeGraphic(50, 50, FlxColor.BLUE);
		enemy.makeGraphic(50, 50, FlxColor.RED);
		platform1.makeGraphic(100, 50, FlxColor.BROWN);
		platform2.makeGraphic(100, 50, FlxColor.BROWN);
		platform3.makeGraphic(100, 50, FlxColor.BROWN);
		player.screenCenter();
		platform1.screenCenter();
		enemy.y = (FlxG.height / 2);
		platform1.y = (FlxG.height / 2) + player.height + 10;
		platform2.y = (FlxG.height / 2) + player.height + 10;
		platform2.x = (FlxG.height / 2) - player.height - 150;
		platform3.y = (FlxG.height / 2) + player.height + 10;
		platform3.x = (FlxG.height / 2) + platform1.height + 150;
		player.acceleration.y = 400;
		player.maxVelocity.y = 200;
		enemy.acceleration.y = 400;
		enemy.maxVelocity.y = 200;
		player.drag.x = player.drag.y = 800;
		enemy.drag.x = enemy.drag.y = 800;
		add(player);
		add(enemy);
		add(platform1);
		add(platform2);
		add(platform3);
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.pressed.R)
			FlxG.switchState(new GameOverState());
		if (FlxG.collide(player, enemy))
			FlxG.switchState(new GameOverState());
		FlxG.collide(player, platform1);
		FlxG.collide(player, platform2);
		FlxG.collide(player, platform3);
		FlxG.collide(enemy, platform1);
		FlxG.collide(enemy, platform2);
		FlxG.collide(enemy, platform3);
		platform1.immovable = true;
		platform2.immovable = true;
		platform3.immovable = true;
		enemyMovment();
		updateMovment();
		super.update(elapsed);
		trace(number);
		var jumpTimer:Float = 0;
		var jumping:Bool = false;
		var jumpPressed:Bool = FlxG.keys.anyPressed([UP, W]);
		if (jumping && !jumpPressed)
			jumping = false;

		if (player.isTouching(DOWN) && !jumping)
			jumpTimer = 0;

		if (jumpTimer >= 0 && jumpPressed)
		{
			jumping = true;
			jumpTimer += elapsed;
		}
		else
			jumpTimer = -1;

		if (jumpTimer > 0 && jumpTimer < 0.25)
			player.velocity.y = -300;
	}

	function updateMovment()
	{
		var left:Bool = false;
		var right:Bool = false;
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);
		if (left && right)
			left = right = false;
		if (left || right)
		{
			player.velocity.x = SPEED;
			player.velocity.y = SPEED;
			if (left)
				newAngle = 180;
			else if (right)
				newAngle = 0;
			player.velocity.setPolarDegrees(SPEED, newAngle);
		}
	}

	function enemyMovment()
	{
		if (number == 0)
			newAngle = 180;
		if (number == 1)
			newAngle = 0;
		if (number == 2)
			enemy.velocity.y = -300;
		enemy.velocity.setPolarDegrees(SPEED, newAngle);
	}
}
