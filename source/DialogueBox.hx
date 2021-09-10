package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitMiddle:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'parish':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'worship':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'zavodila':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'parish':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 390;
			case 'worship':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 390;
			case 'zavodila':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 390;
			case 'gospel':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 390;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		if(PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
		 portraitLeft = new FlxSprite(-20, 40);
		 portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		 portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		 portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		 portraitLeft.updateHitbox();
		 portraitLeft.scrollFactor.set();
		 add(portraitLeft);
		 portraitLeft.visible = false;
		}
		else if (PlayState.SONG.song.toLowerCase() == 'parish' || PlayState.SONG.song.toLowerCase() == 'worship' || PlayState.SONG.song.toLowerCase() == 'zavodila' || PlayState.SONG.song.toLowerCase() == 'gospel')
		{
		 portraitLeft = new FlxSprite(100, 100);
		 portraitLeft.frames = Paths.getSparrowAtlas('');
		 portraitLeft.animation.addByPrefix('enter', '', 24, false);
		 portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
		 portraitLeft.updateHitbox();
		 portraitLeft.scrollFactor.set();
		 add(portraitLeft);
		 portraitLeft.visible = false;
		}
	
		if(PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
		 portraitRight = new FlxSprite(0, 40);
		 portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		 portraitRight.animation.addByPrefix('enter', '', 24, false);
		 portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		 portraitRight.updateHitbox();
		 portraitRight.scrollFactor.set();
		 add(portraitRight);
		 portraitRight.visible = false;
		}
		else if (PlayState.SONG.song.toLowerCase() == 'parish' || PlayState.SONG.song.toLowerCase() == 'worship' || PlayState.SONG.song.toLowerCase() == 'zavodila' || PlayState.SONG.song.toLowerCase() == 'gospel')
		{
		 portraitRight = new FlxSprite(700, 100);
		 portraitRight.frames = Paths.getSparrowAtlas('portraits/BF', 'shared');
		 portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter instance 1', 24, false);
		 portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
		 portraitRight.updateHitbox();
		 portraitRight.scrollFactor.set();
		 add(portraitRight);
		 portraitRight.visible = false;
	
		 portraitMiddle = new FlxSprite(700, 100);
		 portraitMiddle.frames = Paths.getSparrowAtlas('portraits/GFTalk', 'shared');
	 	 portraitMiddle.animation.addByPrefix('enter', 'Senpai portrait enter instance 1', 24, false);
		 portraitMiddle.setGraphicSize(Std.int(portraitMiddle.width * PlayState.daPixelZoom * 0.15));
		 portraitMiddle.updateHitbox();
		 portraitMiddle.scrollFactor.set();
		 add(portraitMiddle);
		 portraitMiddle.visible = false;
		}
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		//portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		if(PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
		 dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		 dropText.font = 'Pixel Arial 11 Bold';
		 dropText.color = 0xFFD89494;
		 add(dropText);
	
		 swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		 swagDialogue.font = 'Pixel Arial 11 Bold';
		 swagDialogue.color = 0xFF3F2021;
		 swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		 add(swagDialogue);
	
		 dialogue = new Alphabet(0, 80, "", false, true);
		 // dialogue.x = 90;
		 // add(dialogue);
		}
			
		else if (PlayState.SONG.song.toLowerCase() == 'parish' || PlayState.SONG.song.toLowerCase() == 'worship' || PlayState.SONG.song.toLowerCase() == 'zavodila' || PlayState.SONG.song.toLowerCase() == 'gospel')
		{
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'Komika Display';
			dropText.color = 0xFFA9038C;
			add(dropText);
		
			swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
			swagDialogue.font = 'Komika Display';
			swagDialogue.color = FlxColor.BLACK;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
			add(swagDialogue);
		   
			dialogue = new Alphabet(0, 80, "", false, true);
			// dialogue.x = 90;
			// add(dialogue);
		}
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.visible = false;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		switch (curCharacter)
		{
			case 'bf':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelBText'), 0.6)];
			case 'bfhappy':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelBText'), 0.6)];
			case 'gf':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelBText'), 0.6)];
			case 'sarvhappy':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('sarv_sound'), 12)];
			case 'sarvsad':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('sarv_sound'), 12)];
			case 'sarvsmile':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('sarv_sound'), 12)];
			case 'sarvangry':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('sarv_sound'), 12)];
			case 'sarvupset':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('sarv_sound'), 12)];
			case 'ruv':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('ruv_sound'), 12)];
			case 'ruvangry':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('ruv_sound'), 12)];
			case 'ruvbruh':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('ruv_sound'), 12)];
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'parish' || PlayState.SONG.song.toLowerCase() == 'worship' || PlayState.SONG.song.toLowerCase() == 'zavodila' || PlayState.SONG.song.toLowerCase() == 'gospel')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'bfhappy':
				portraitLeft.visible = false;
				portraitMiddle.visible = false;
				portraitRight.frames = Paths.getSparrowAtlas('portraits/BFBeep');
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'bfsad':
				portraitLeft.visible = false;
				portraitMiddle.visible = false;
				portraitRight.frames = Paths.getSparrowAtlas('portraits/BFUhh');
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'gf':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitMiddle.frames = Paths.getSparrowAtlas('portraits/GFTalk');
				if (!portraitMiddle.visible)
				{
					portraitMiddle.visible = true;
					portraitMiddle.animation.play('enter');
				}
			case 'gfhappy':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitMiddle.frames = Paths.getSparrowAtlas('portraits/GFCheer');
				if (!portraitMiddle.visible)
				{
					portraitMiddle.visible = true;
					portraitMiddle.animation.play('enter');
				}
			case 'sarvhappy':
				portraitRight.visible = false;
				portraitMiddle.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/SarvHappy');
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'sarvsad':
				portraitRight.visible = false;
				portraitMiddle.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/SarvPout');
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'sarvsmile':
				portraitRight.visible = false;
				portraitMiddle.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/SarvSmile');
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'sarvangry':
				portraitRight.visible = false;
				portraitMiddle.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/DarkSarvMad');
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'sarvupset':
				portraitRight.visible = false;
				portraitMiddle.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/DarkSarvUnamused');
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'ruv':
				portraitRight.visible = false;
				portraitMiddle.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/Ruv');
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'ruvangry':
				portraitRight.visible = false;
				portraitMiddle.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/RuvDisgusted');
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'ruvbruh':
				portraitRight.visible = false;
				portraitMiddle.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/RuvTalk');
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'sarvdevil':
				portraitRight.visible = false;
				portraitMiddle.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/LuciSarv');
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
