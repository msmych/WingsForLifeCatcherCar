using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class Runner extends Ui.Drawable {

	hidden var layout = FULL;

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
		bitmap.locY = getBitmapY(dc);
		bitmap.draw(dc);
	}
	
	hidden function getBitmapY(dc) {
		switch (layout) {
			case ROUND:
				return dc.getHeight()/2 + dc.getFontHeight(Gfx.FONT_LARGE)/2;
			case BOTTOM:
			case BOTTOM_LEFT:
			case BOTTOM_RIGHT:
				return 0;
			default:
				return dc.getHeight() - bitmap.getDimensions()[1];
		}
	}
	
	function setLayout(newLayout) {
		layout = newLayout;
	}
}