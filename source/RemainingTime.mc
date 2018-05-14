using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class RemainingTime extends Ui.Drawable {

	hidden var text = "0:00:00";
	
	function initialize() {
		var settings = {
			:identifier => "RemainingTime"
		};
		
		Drawable.initialize(settings);
	}
	
	function update(remainingTime, finished) {
		if (finished) {
			text = "Finished";
		} else {
			var time = remainingTime.toNumber();
			var hours = time / MILLISECONDS_IN_HOUR;
			time -= hours * MILLISECONDS_IN_HOUR;
			var minutes = time / MILLISECONDS_IN_MINUTE;
			time -= minutes * MILLISECONDS_IN_MINUTE;
			var seconds = time / MILLISECONDS_IN_SECOND;
			text = hours
					+ ":" + (minutes < 10 ? "0" : "") + minutes
					+ ":" + (seconds < 10 ? "0" : "") + seconds;
		}
	}
	
	function draw(dc) {
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		dc.drawText(
				dc.getWidth()*1/4, 
				dc.getHeight()/2, 
				Gfx.FONT_LARGE, 
				text, 
				Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
	}
}