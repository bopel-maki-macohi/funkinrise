import funkin.modding.module.Module;
import funkin.ui.title.TitleState;
import funkin.util.ReflectUtil;
import funkin.graphics.FunkinSprite;
import funkin.Conductor;
import flixel.util.FlxTimer;

class FRTitleState extends Module
{
	public function new()
	{
		super('FRTitleState');
	}

	var stage:FunkinSprite = null;
	var boy:FunkinSprite = null;
	var lightBack:FunkinSprite = null;
	var logo:FunkinSprite = null;

	public function onStateChangeBegin(e)
	{
		Conductor.instance.onBeatHit.remove(boyBop);
		boy = null;
	}

	public function onStateChangeEnd(e)
	{
		if (ReflectUtil.getClassNameOf(FlxG.state) == 'funkin.ui.title.TitleState')
		{
			trace(TitleState.initialized);
			if (!TitleState.initialized)
			{
				new FlxTimer().start(1, function(t)
				{
					replaceTitle();

					FlxG.state.insert(FlxG.state.members.indexOf(FlxG.state.credGroup), stage);
					FlxG.state.insert(FlxG.state.members.indexOf(stage), boy);
					FlxG.state.insert(FlxG.state.members.indexOf(boy), lightBack);
					FlxG.state.insert(FlxG.state.members.indexOf(lightBack), logo);
				});
			}
			else
			{
				replaceTitle();

				FlxG.state.add(stage);
				FlxG.state.add(boy);
				FlxG.state.add(lightBack);
				FlxG.state.add(logo);
			}
		}
	}

	function replaceTitle()
	{
		FlxG.state.remove(FlxG.state.logoBl);
		FlxG.state.remove(FlxG.state.gfDance);

		var sx = 250;

		var yoff = -25;

		stage = new FunkinSprite();
		stage.loadGraphic(Paths.image('title/stage'));
		stage.screenCenter();
		stage.x -= sx;
		stage.y += 150 + yoff;

		lightBack = new FunkinSprite();
		lightBack.loadGraphic(Paths.image('title/light back'));
		lightBack.screenCenter();
		lightBack.x += 300;
		lightBack.y += 75 + yoff;

		logo = new FunkinSprite();
		logo.loadGraphic(Paths.image('title/logo'));
		logo.screenCenter();
		logo.x += 375;
		logo.y += 125 + yoff;

		boy = FunkinSprite.createTextureAtlas(0, 0, 'title/boy');
		boy.anim.addByFrameLabel('idle', "bop", 24, false);
		boy.screenCenter();
		boy.x -= sx;
		boy.shader = FlxG.state.swagShader.shader;

		boy.animation.play('idle');

		Conductor.instance.onBeatHit.remove(boyBop);
		Conductor.instance.onBeatHit.add(boyBop);

		FlxG.state.titleText.y = 25;
	}

	function boyBop()
	{
		if (boy == null) return;
		if (boy.animation == null) return;

		boy.animation.play('idle');
	}
}
