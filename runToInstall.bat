@echo off
echo installing stuff...
haxelib install lime 7.9.0
haxelib install openfl 9.2.2
haxelib install flixel 4.11.0
haxelib install flixel-tools 1.5.1
haxelib install flixel-ui 2.5.0
haxelib install hscript 2.5.0
haxelib install flixel-addons 2.11.0
haxelib install actuate
haxelib run lime setup
haxelib run lime setup flixel
haxelib run flixel-tools setup
haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit.git
haxelib git hxvm-luajit https://github.com/nebulazorua/hxvm-luajit
haxelib git faxe https://github.com/uhrobots/faxe
haxelib git polymod https://github.com/MasterEric/polymod.git
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
haxelib git extension-webm https://github.com/KadeDev/extension-webm
lime rebuild extension-webm windows
lime test windows