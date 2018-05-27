using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
	
class CatcherCar extends Ui.Drawable {

	hidden var layout = WingsForLifeCatcherCarView.FULL;
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
		bitmap.locY = getBitmapY(dc);
		bitmap.draw(dc);
		drawDistanceFromRunner(dc);
	}
	
	function drawDistanceFromRunner(dc) {
		if (distanceFromRunner > 0) {
			return;
		}
		var formattedDistanceFromRunner = distanceFromRunner < 0 ? (distanceFromRunner/METERS_IN_KILOMETER).format("%.2f") : "";
		var position = distance/finish * dc.getWidth() - bitmap.getDimensions()[1];
		if (distanceFromRunnerFits(dc, formattedDistanceFromRunner, position)) {
			dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
			dc.drawText(
					getDistanceFromRunnerX(dc, position), 
					getDistanceFromRunnerY(dc),
					Gfx.FONT_XTINY,
					formattedDistanceFromRunner,
					getDistanceFromRunnerJustification());
		}
	}
	
	hidden function getBitmapY(dc) {
		switch (layout) {
			case WingsForLifeCatcherCarView.ROUND:
				return dc.getHeight()/2 + dc.getFontHeight(Gfx.FONT_LARGE)/2;
			case WingsForLifeCatcherCarView.BOTTOM:
			case WingsForLifeCatcherCarView.BOTTOM_LEFT:
			case WingsForLifeCatcherCarView.BOTTOM_RIGHT:
				return 0;
			default:
				return dc.getHeight() - bitmap.getDimensions()[1];
		}
	}
	
	hidden function distanceFromRunnerFits(dc, formattedDistanceFromRunner, position) {
		switch (layout) {
			case WingsForLifeCatcherCarView.TOP_LEFT:
			case WingsForLifeCatcherCarView.TOP_RIGHT:
			case WingsForLifeCatcherCarView.TOP:
			case WingsForLifeCatcherCarView.BOTTOM:
			case WingsForLifeCatcherCarView.BOTTOM_LEFT:
			case WingsForLifeCatcherCarView.BOTTOM_RIGHT:
				return true;
			default:
				return dc.getTextWidthInPixels(formattedDistanceFromRunner, Gfx.FONT_XTINY) < position;
		}
	}
	
	hidden function getDistanceFromRunnerX(dc, position) {
		switch (layout) {
			case WingsForLifeCatcherCarView.TOP_LEFT:
			case WingsForLifeCatcherCarView.BOTTOM_LEFT:
				return dc.getWidth()*24/25;
			case WingsForLifeCatcherCarView.TOP_RIGHT:
			case WingsForLifeCatcherCarView.BOTTOM_RIGHT:
				return dc.getWidth()/25;
			case WingsForLifeCatcherCarView.TOP:
			case WingsForLifeCatcherCarView.BOTTOM:
				return dc.getWidth()/2;
			default:
				return position;
		}
	}
	
	hidden function getDistanceFromRunnerY(dc) {
		switch (layout) {
			case WingsForLifeCatcherCarView.TOP_LEFT:
			case WingsForLifeCatcherCarView.TOP_RIGHT:
				return dc.getHeight() - dc.getFontHeight(Gfx.FONT_LARGE)*2 - dc.getFontHeight(Gfx.FONT_XTINY)/2;
			case WingsForLifeCatcherCarView.BOTTOM_LEFT:
			case WingsForLifeCatcherCarView.BOTTOM_RIGHT:
				return dc.getFontHeight(Gfx.FONT_LARGE)*2 + dc.getFontHeight(Gfx.FONT_XTINY)/2;
			case WingsForLifeCatcherCarView.ROUND:
				return dc.getHeight()/2 + dc.getFontHeight(Gfx.FONT_LARGE)/2 + bitmap.getDimensions()[1]/2 - dc.getFontHeight(Gfx.FONT_XTINY)/2;
			case WingsForLifeCatcherCarView.TOP:
				var yTop = dc.getHeight() - dc.getFontHeight(Gfx.FONT_LARGE) - dc.getFontHeight(Gfx.FONT_XTINY)/2;
				if (dc.getHeight() >= dc.getFontHeight(Gfx.FONT_LARGE) + dc.getFontHeight(Gfx.FONT_XTINY)*2) {
					yTop -= dc.getFontHeight(Gfx.FONT_XTINY);
				}
				return yTop;
			case WingsForLifeCatcherCarView.BOTTOM:
				var yBottom = dc.getFontHeight(Gfx.FONT_LARGE) + dc.getFontHeight(Gfx.FONT_XTINY)/2;
				if (dc.getHeight() >= dc.getFontHeight(Gfx.FONT_LARGE) + dc.getFontHeight(Gfx.FONT_XTINY)*2) {
					yBottom += dc.getFontHeight(Gfx.FONT_XTINY);
				}
				return yBottom;
			default:
				return dc.getHeight() - bitmap.getDimensions()[1]/2 - dc.getFontHeight(Gfx.FONT_XTINY)/2;
		}
	}
	
	hidden function getDistanceFromRunnerJustification() {
		switch (layout) {
			case WingsForLifeCatcherCarView.TOP_LEFT:
			case WingsForLifeCatcherCarView.BOTTOM_LEFT:
				return Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER;
			case WingsForLifeCatcherCarView.TOP_RIGHT:
			case WingsForLifeCatcherCarView.BOTTOM_RIGHT:
				return Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER;
			case WingsForLifeCatcherCarView.TOP:
			case WingsForLifeCatcherCarView.BOTTOM:
				return Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
			default:
				return Gfx.TEXT_JUSTIFY_RIGHT;
		}
	}
	
	function setLayout(newLayout) {
		layout = newLayout;
	}
	
}