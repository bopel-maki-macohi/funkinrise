import funkin.modding.module.Module;
import funkin.ui.mainmenu.MainMenuState;
import funkin.util.ReflectUtil;

class FRMainMenuState extends Module
{
	public function new()
	{
		super('FRMainMenuState');
	}

	public function onStateChangeEnd(e)
	{
		if (ReflectUtil.getClassNameOf(FlxG.state) == 'funkin.ui.mainmenu.MainMenuState')
		{
			var watermark = FlxG.state.rightWatermarkText;

			if (watermark == null) return;

			watermark.text = 'FUNKIN RISE';
		}
	}
}
