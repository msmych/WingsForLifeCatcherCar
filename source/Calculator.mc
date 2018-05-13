using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Attention as Attention;

const METERS_IN_KILOMETER = 1000;
const KPS_IN_MPMS = 3.6f * MILLISECONDS_IN_SECOND;
const MILLISECONDS_IN_SECOND = 1000;
const MILLISECONDS_IN_MINUTE = 60 * MILLISECONDS_IN_SECOND;
const MILLISECONDS_IN_HOUR = 60 * MILLISECONDS_IN_MINUTE;

const CHAMPION_FINISH = 100 * METERS_IN_KILOMETER;
const WAITING_TIME = 30 * MILLISECONDS_IN_MINUTE;

const TRAVELLING1_SPEED_KPH = 15;
const TRAVELLING2_SPEED_KPH = 16;
const TRAVELLING3_SPEED_KPH = 17;
const TRAVELLING4_SPEED_KPH = 20;
const TRAVELLING5_SPEED_KPH = 35;

const TRAVELLING1_TIME = 60 * MILLISECONDS_IN_MINUTE;
const TRAVELLING2_TIME = 60 * MILLISECONDS_IN_MINUTE;
const TRAVELLING3_TIME = 60 * MILLISECONDS_IN_MINUTE;
const TRAVELLING4_TIME = 120 * MILLISECONDS_IN_MINUTE;
const CHECKPOINT1_TIME = WAITING_TIME + TRAVELLING1_TIME;
const CHECKPOINT2_TIME = CHECKPOINT1_TIME + TRAVELLING2_TIME;
const CHECKPOINT3_TIME = CHECKPOINT2_TIME + TRAVELLING3_TIME;
const CHECKPOINT4_TIME = CHECKPOINT3_TIME + TRAVELLING4_TIME;

const TRAVELLING1 = TRAVELLING1_SPEED_KPH * METERS_IN_KILOMETER;
const TRAVELLING2 = TRAVELLING2_SPEED_KPH * METERS_IN_KILOMETER;
const TRAVELLING3 = TRAVELLING3_SPEED_KPH * METERS_IN_KILOMETER;
const TRAVELLING4 = 2 * TRAVELLING4_SPEED_KPH * METERS_IN_KILOMETER;

const CHECKPOINT1 = TRAVELLING1;
const CHECKPOINT2 = CHECKPOINT1 + TRAVELLING2;
const CHECKPOINT3 = CHECKPOINT2 + TRAVELLING3;
const CHECKPOINT4 = CHECKPOINT3 + TRAVELLING4;

const TRAVELLING1_SPEED = TRAVELLING1_SPEED_KPH / KPS_IN_MPMS;
const TRAVELLING2_SPEED = TRAVELLING2_SPEED_KPH / KPS_IN_MPMS;
const TRAVELLING3_SPEED = TRAVELLING3_SPEED_KPH / KPS_IN_MPMS;
const TRAVELLING4_SPEED = TRAVELLING4_SPEED_KPH / KPS_IN_MPMS;
const TRAVELLING5_SPEED = TRAVELLING5_SPEED_KPH / KPS_IN_MPMS;


class Calculator extends Ui.Drawable {

	hidden var finish = 0;
	hidden var finished = false;
	hidden var timeToFinish = 0;

	function initialize() {
		var settings = {
			:identifier => "Calculator"
		};
		Drawable.initialize(settings);
	}
	
	function calculate(info, catcherCarDistance) {
		var fin = 0;
		var distance = info has :elapsedDistance and info.elapsedDistance != null ? info.elapsedDistance : 0.0f;
		var time = info has :elapsedTime and info.elapsedTime != null ? info.elapsedTime : 0;
		var speed = info has :averageSpeed and info.averageSpeed != null ? info.averageSpeed / MILLISECONDS_IN_SECOND : 0.0f;
		
		if (!finished and catcherCarDistance > distance) {
			finished = true;
			congratulateFinish();
		}
		
		if (finished) {
			fin = finish;
			timeToFinish = 0;
		} else if (distance == 0.0f) {
			fin = catcherCarDistance > distance ? 0 : CHAMPION_FINISH;
		} else if (speed * CHECKPOINT1_TIME < CHECKPOINT1) {
			var finishTime = TRAVELLING1_SPEED * WAITING_TIME / (TRAVELLING1_SPEED - speed);
			timeToFinish = finishTime - time;
			fin = distance + speed * timeToFinish;
		} else if (speed * CHECKPOINT2_TIME < CHECKPOINT2) {
			var finishTime = (CHECKPOINT1 - TRAVELLING2_SPEED * CHECKPOINT1_TIME) / (speed - TRAVELLING2_SPEED);
			timeToFinish = finishTime - time;
			fin = distance + speed * timeToFinish;
		} else if (speed * CHECKPOINT3_TIME < CHECKPOINT3) {
			var finishTime = (CHECKPOINT2 - TRAVELLING3_SPEED * CHECKPOINT2_TIME) / (speed - TRAVELLING3_SPEED);
			timeToFinish = finishTime - time;
			fin = distance + speed * timeToFinish;
		} else if (speed * CHECKPOINT4_TIME < CHECKPOINT4) {
			var finishTime = (CHECKPOINT3 - TRAVELLING4_SPEED * CHECKPOINT3_TIME) / (speed - TRAVELLING4_SPEED);
			timeToFinish = finishTime - time;
			fin = distance + speed * timeToFinish;
		} else {
			var finishTime = (CHECKPOINT4 - TRAVELLING5_SPEED * CHECKPOINT4_TIME) / (speed - TRAVELLING5_SPEED);
			var timeToFin = finishTime - time;
			fin = distance + speed * timeToFin;
			if (fin > CHAMPION_FINISH) {
				fin = CHAMPION_FINISH;
				timeToFin = (CHAMPION_FINISH - distance) / speed - time;
			}
			timeToFinish = timeToFin;
		}
		
		finish = fin; 
		return fin;
	}
	
	function draw(dc) {
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		dc.drawText(
				dc.getWidth()*1/4, 
				dc.getHeight()/2, 
				Gfx.FONT_LARGE, 
				formatTimeToFinish(), 
				Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		dc.drawText(
				dc.getWidth()*3/4,
				dc.getHeight()/2,
				Gfx.FONT_LARGE,
				(finish/METERS_IN_KILOMETER).format("%.2f"),
				Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
	}
	
	hidden function formatTimeToFinish() {
		if (finished) {
			return "Finished";
		}
		var time = timeToFinish.toNumber();
		var hours = time / MILLISECONDS_IN_HOUR;
		time -= hours * MILLISECONDS_IN_HOUR;
		var minutes = time / MILLISECONDS_IN_MINUTE;
		time -= minutes * MILLISECONDS_IN_MINUTE;
		var seconds = time / MILLISECONDS_IN_SECOND;
		return hours
				+ ":" + (minutes < 10 ? "0" : "") + minutes
				+ ":" + (seconds < 10 ? "0" : "") + seconds;
	}
	
	hidden function congratulateFinish() {
		if (finished) {
			backlight();
			vibrate();
		}
	}
	
	hidden function backlight() {
		if (Attention has :backlight) {
			Attention.backlight(true);
		}
	}
	
	hidden function vibrate() {
		if (Attention has :vibrate) {
			var vibeProfile = [ new Attention.VibeProfile(50, 1000) ];
			Attention.vibrate(vibeProfile);
		}
	}
}