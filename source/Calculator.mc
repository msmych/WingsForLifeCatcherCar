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


class Calculator {

	hidden var finish = 0;
	hidden var finished = false;
	hidden var timeToFinish = 0;
	
	hidden var catcherCarDistance = 0;
	hidden var runnerDistance = 0;
	
	function calculate(info) {
		var distance = info has :elapsedDistance and info.elapsedDistance != null ? info.elapsedDistance : 0;
		runnerDistance = distance;
		var time = info has :elapsedTime and info.elapsedTime != null ? info.elapsedTime : 0;
		var speed = info has :averageSpeed and info.averageSpeed != null ? info.averageSpeed / MILLISECONDS_IN_SECOND : 0;
		
		catcherCarDistance = calculateCatcherCarDistance(time);
		
		if (!finished and catcherCarDistance > distance) {
			finished = true;
			congratulateFinish();
		}
		
		finish = calculateFinish(distance, time, speed);
	}
	
	hidden function calculateCatcherCarDistance(time) {
		var dist = 0;
		dist += getTravelling1Distance(time);
		dist += getTravelling2Distance(time);
		dist += getTravelling3Distance(time);
		dist += getTravelling4Distance(time);
		dist += getTravelling5Distance(time);
		return dist;
	}
	
	hidden function calculateFinish(distance, time, speed) {
		var fin = 0;
		if (finished) {
			fin = finish;
			timeToFinish = 0;
		} else if (distance == 0) {
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
		
		return fin;
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
	
	hidden function congratulateFinish() {
		turnOnBacklight();
		vibrate();
	}
	
	hidden function turnOnBacklight() {
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
	
	function getCatcherCarDistance() {
		return catcherCarDistance;
	}
	
	function getRunnerDistance() {
		return runnerDistance;
	}
	
	function getRemainingTime() {
		return timeToFinish;
	}
	
	function getFinish() {
		return finish;
	}
	
	function isFinished() {
		return finished;
	}
}