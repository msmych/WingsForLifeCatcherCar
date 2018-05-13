using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
	
class CatcherCar extends Ui.Drawable {

	hidden var distance = 0;
	hidden var finish = CHAMPION_FINISH;
	hidden var distanceFromRunner = 0;
	hidden var bitmap;
	
	function initialize() {
		var settings = {
			:identifier => "CatcherCar"
		};
		Drawable.initialize(settings);
		bitmap = new Ui.Bitmap({
			:rezId => Rez.Drawables.catcherCarBitmap
		});
	}
	
	function update(info) {
		var dist = 0;
		var time = info has :elapsedTime and info.elapsedTime != null ? info.elapsedTime : 0;
		dist += getTravelling1Distance(time);
		dist += getTravelling2Distance(time);
		dist += getTravelling3Distance(time);
		dist += getTravelling4Distance(time);
		dist += getTravelling5Distance(time);
		distance = dist;
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
	
	hidden function getTravelling1Distance(time) {
		var dist = 0;
		if (time > WAITING_TIME) {
			var intervalTime = time - WAITING_TIME;
			dist = intervalTime < TRAVELLING1_TIME
					? intervalTime * TRAVELLING1_SPEED
					: TRAVELLING1;
		}
		return dist;
	}
	
	hidden function getTravelling2Distance(time) {
		var dist = 0;
		if (time > CHECKPOINT1_TIME) {
			var intervalTime = time - CHECKPOINT1_TIME;
			dist = intervalTime < TRAVELLING2_TIME
					? intervalTime * TRAVELLING2_SPEED
					: TRAVELLING2;
		}
		return dist;
	}
	
	hidden function getTravelling3Distance(time) {
		var dist = 0;
		if (time > CHECKPOINT2_TIME) {
			var intervalTime = time - CHECKPOINT2_TIME;
			dist = intervalTime < TRAVELLING3_TIME
					? intervalTime * TRAVELLING3_SPEED
					: TRAVELLING3;
		}
		return dist;
	}
	
	hidden function getTravelling4Distance(time) {
		var dist = 0;
		if (time > CHECKPOINT3_TIME) {
			var intervalTime = time - CHECKPOINT3_TIME;
			dist = intervalTime < TRAVELLING4_TIME
					? intervalTime * TRAVELLING4_SPEED
					: TRAVELLING4;
		}
		return dist;
	}
	
	hidden function getTravelling5Distance(time) {
		var dist = 0;
		if (time > CHECKPOINT4_TIME) {
			dist = (time - CHECKPOINT4_TIME) * TRAVELLING5_SPEED;
		}
		return dist;
	}
	
	function getDistance() {
		return distance;
	}
	
	function setFinish(estimatedFinish) {
		finish = estimatedFinish;
	}
	
	function setDistanceFromRunner(runnerDistance) {
		distanceFromRunner = distance - runnerDistance;
	}
}