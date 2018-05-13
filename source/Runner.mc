using Toybox.WatchUi as Ui;

class Runner extends Ui.Drawable {

	hidden var distance = 0;
	hidden var finish = CHAMPION_FINISH;
	
	hidden var bitmap;
	
	function initialize() {
		var settings = {
			:identifier => "Runner"
		};
		Drawable.initialize(settings);
		bitmap = new Ui.Bitmap({
			:rezId => Rez.Drawables.runnerBitmap
		});
	}
	
	function update(info, estimatedFinish) {
		if (info has :elapsedDistance and info.elapsedDistance != null) {
			distance = info.elapsedDistance;
		}
		finish = estimatedFinish;
	}
	
	function draw(dc) {
		bitmap.locX = distance/finish * (dc.getWidth() - bitmap.getDimensions()[0]);
		bitmap.locY = dc.getHeight() - bitmap.getDimensions()[1];
		bitmap.draw(dc);
	}
	
	function getDistance() {
		return distance;
	}
	
}