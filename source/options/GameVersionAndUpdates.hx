package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import openfl.Lib;

using StringTools;

class GameVersionAndUpdates extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Updates And Information';
		rpcTitle = 'Game Updates And Information Menu'; //for Discord Rich Presence

		var option:Option = new Option('Reinstall this version', //Name
			'This forces reinstallation, via auto update.\nThis only works when you have a network connection.', //Description
			'reinstallthisver', //Save data variable name
			'reinstall' //Variable type
		); //Default value
		addOption(option);
		
		var option2:Option = new Option('Version: ' + MainMenuState.FNFVsGvbVersion.trim(), //Name
			'What your current FNF Vs Gvbvdxx version is.', //Description
			'versionlabel', //Save data variable name
			'label' //Variable type
		); //Default value
		addOption(option2);

		super();
	}
}