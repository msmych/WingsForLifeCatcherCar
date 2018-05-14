using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
	
class CatcherCar extends Ui.Drawable {

	hidden var bitmap;

	hidden var distance = 0;
	hidden var distanceFromRunner = 0;
	hidden var finish = CHAMPION_FINISH;
	
	function initialize() {
		var settings = {
			:identifier => "CatcherCar"
		};
		Drawable.initialize(settings);
		bitmap = new Ui.Bitmap({
			:rezId => Rez.Drawables.catcherCarBitmap
		});
	}
	
	function update(catcherCarDistance, runnerDistance, estimatedFinish) {
		distance = catcherCarDistance;
		distanceFromRunner = distance - runnerDistance;
		finish = estimatedFinish;
	}
	
	function draw(dc) {
		if (finish == 0) {
			return;
		}
		bitmap.locX = distance/finish * dc.getWidth() - bitmap.getDimensions()[0];
		bitmap.locY = dc.getHeight() - bitmap.getDimensions()[1];
		bitmap.draw(dc);
		drawDistanceFromRunner(dc);
	}
	
	function drawDistanceFromRunner(dc) {
		if (distanceFromRunner > 0) {
			return;
		}
		var formattedDistanceFromRunner = (distanceFromRunner/METERS_IN_KILOMETER).format("%.2f");
		var position = distance/finish * dc.getWidth() - bitmap.getDimensions()[1];
		if (dc.getTextWidthInPixels(formattedDistanceFromRunner, Gfx.FONT_XTINY) < position) {
			dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
			dc.drawText(
					position, 
					dc.getHeight() - bitmap.getDimensions()[1]/2 - dc.getFontHeight(Gfx.FONT_XTINY)/2,
					Gfx.FONT_XTINY,
					formattedDistanceFromRunner,
					Gfx.TEXT_JUSTIFY_RIGHT);
		}
	}
	
}