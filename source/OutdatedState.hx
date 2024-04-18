package;

import flixel.addons.display.FlxBackdrop;
import openfl.display.BlendMode;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class OutdatedState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	var updateText:FlxText;
	var checker:FlxBackdrop;
	override function create()
	{
		super.create();
		
		var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("main-menu"));
		bg.scale.set(1.1, 1.1);
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);
		
		checker = new FlxBackdrop(Paths.image('checker', 'preload'));
		checker.scale.set(1.4, 1.4);
		checker.color = 0xFF890FF5;
		checker.blend = BlendMode.LAYER;
		add(checker);
		checker.scrollFactor.set(0, 0.07);
		checker.alpha = 0.2;
		checker.updateHitbox();
		
		warnText = new FlxText(0, 10, FlxG.width,
			"HEY! Your FNF Vs Gvbvdxx is outdated!\n"
			+ 'current version: V' + MainMenuState.FNFVsGvbVersion + '\nexpected version: V' + TitleState.updateVersion + '\n'
			,32);
		warnText.setFormat(Paths.font("vcr.ttf"), 25, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
		
		
		updateText = new FlxText(0, 10, FlxG.width,
			"Press SPACE to download manually, ENTER to auto update or ESCAPE to ignore this!"
			,24);
		updateText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		updateText.y = 710 - updateText.height;
		updateText.x = 10;
		add(updateText);
	}

	override function update(elapsed:Float)
	{
		checker.x += elapsed * 100;
		checker.y += elapsed * 100;
		
		if(!leftState) {
			if (FlxG.keys.justPressed.ENTER) {
				leftState = true;
				#if windows
				MusicBeatState.switchState(new UpdateState());
				#else
				CoolUtil.browserLoad("https://github.com/gvbvdxx/FNFVsGvbvdxxEngine/releases/latest");
				#end
			}
			if (FlxG.keys.justPressed.SPACE) {
				leftState = true;
				CoolUtil.browserLoad("https://github.com/gvbvdxx/FNFVsGvbvdxxEngine/releases/latest");
			}
			if(controls.BACK) {
				leftState = true;
			}

			if(leftState)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new MainMenuState());
					}
				});
			}
		}
		super.update(elapsed);
	}
}
