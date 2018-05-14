using Toybox.WatchUi as Ui;

class Runner extends Ui.Drawable {

	hidden var bitmap;

	hidden var distance = 0;
	hidden var finish = CHAMPION_FINISH;	
	
	function initialize() {
		var settings = {
			:identifier => "Runner"
		};
		Drawable.initialize(settings);
		bitmap = new Ui.Bitmap({
			:rezId => Rez.Drawables.runnerBitmap
		});
	}
	
	function update(elapsedDistance, estimatedFinish) {
		distance = elapsedDistance;
		finish = estimatedFinish;
	}
	
	function draw(dc) {
		if (finish == 0) {
			return;
		}
		bitmap.locX = distance/finish * (dc.getWidth() - bitmap.getDimensions()[0]);
		bitmap.locY = dc.getHeight() - bitmap.getDimensions()[1];
		bitmap.draw(dc);
	}
}