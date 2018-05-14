using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class Finish extends Ui.Drawable {
	
	hidden var finish = CHAMPION_FINISH;
	
	function initialize() {
		var settings = {
			:identifier => "Finish"
		};
		Drawable.initialize(settings);
	}
	
	function update(estimatedFinish) {
		finish = estimatedFinish;
	}
	
	function draw(dc) {
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		dc.drawText(
				dc.getWidth()*3/4,
				dc.getHeight()/2,
				Gfx.FONT_LARGE,
				(finish/METERS_IN_KILOMETER).format("%.2f"),
				Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
	}
}