using Toybox.Attention as Attention;

const METERS_IN_KILOMETER = 1000;
const MILLISECONDS_IN_SECOND = 1000;
const KPS_IN_MPMS = 3.6f * MILLISECONDS_IN_SECOND;
const MILLISECONDS_IN_MINUTE = 60 * MILLISECONDS_IN_SECOND;
const MILLISECONDS_IN_HOUR = 60 * MILLISECONDS_IN_MINUTE;

const CHAMPION_FINISH = 100 * METERS_IN_KILOMETER;

const CAR_SPEED_ARRAY = [0, 14, 15, 16, 17, 18, 22, 26, 30, 34];

const INTERVAL_TIME = 30 * MILLISECONDS_IN_MINUTE;

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
		for (var i = 1; i <= 8; i++) {
			dist += getTravellingDistance(time, getCheckpointTime(i - 1), getTravellingSpeed(i), getTravelling(i));
		}
		return dist + getFinishingDistance(time);
	}
		
	hidden function calculateFinish(distance, time, speed) {
		var fin = 0;
		if (finished) {
			fin = finish;
			timeToFinish = 0;
		} else if (distance == 0) {
			fin = catcherCarDistance > distance ? 0 : CHAMPION_FINISH;
		} else if (speed * getCheckpointTime(1) < getCheckpoint(1)) {
			var finishTime = getTravellingSpeed(1) * INTERVAL_TIME / (getTravellingSpeed(1) - speed);
			timeToFinish = finishTime - time;
			fin = distance + speed * timeToFinish;
		} else {
			for (var i = 1; i <= 8; i++) {
				if (speed * getCheckpointTime(i + 1) < getCheckpoint(i + 1)) {
					var finishTime = (getCheckpoint(i) - getTravellingSpeed(i + 1) * getCheckpointTime(i)) / (speed - getTravellingSpeed(i + 1));
					timeToFinish = finishTime - time;
					return  distance + speed * timeToFinish;
				}
			}		
			/* if (speed * getCheckpointTime(2) < getCheckpoint(2)) {
				var finishTime = (getCheckpoint(1) - getTravellingSpeed(2) * getCheckpointTime(1)) / (speed - getTravellingSpeed(2));
				timeToFinish = finishTime - time;
				fin = distance + speed * timeToFinish;
			} else if (speed * getCheckpointTime(3) < getCheckpoint(3)) {
				var finishTime = (getCheckpoint(2) - getTravellingSpeed(3) * getCheckpointTime(2)) / (speed - getTravellingSpeed(3));
				timeToFinish = finishTime - time;
				fin = distance + speed * timeToFinish;
			} else if (speed * getCheckpointTime(4) < getCheckpoint(4)) {
				var finishTime = (getCheckpoint(3) - getTravellingSpeed(4) * getCheckpointTime(3)) / (speed - getTravellingSpeed(4));
				timeToFinish = finishTime - time;
				fin = distance + speed * timeToFinish;
			} else if (speed * getCheckpointTime(5) < getCheckpoint(5)) {
				var finishTime = (getCheckpoint(4) - getTravellingSpeed(5) * getCheckpointTime(4)) / (speed - getTravellingSpeed(5));
				timeToFinish = finishTime - time;
				fin = distance + speed * timeToFinish;
			} else if (speed * getCheckpointTime(6) < getCheckpoint(6)) {
				var finishTime = (getCheckpoint(5) - getTravellingSpeed(6) * getCheckpointTime(5)) / (speed - getTravellingSpeed(6));
				timeToFinish = finishTime - time;
				fin = distance + speed * timeToFinish;
			} else if (speed * getCheckpointTime(7) < getCheckpoint(7)) {
				var finishTime = (getCheckpoint(6) - getTravellingSpeed(7) * getCheckpointTime(6)) / (speed - getTravellingSpeed(7));
				timeToFinish = finishTime - time;
				fin = distance + speed * timeToFinish;
			} else if (speed * getCheckpointTime(8) < getCheckpoint(8)) {
				var finishTime = (getCheckpoint(7) - getTravellingSpeed(8) * getCheckpointTime(7)) / (speed - getTravellingSpeed(8));
				timeToFinish = finishTime - time;
				fin = distance + speed * timeToFinish;
			} else {*/
			var finishTime = (getCheckpoint(8) - getTravellingSpeed(9) * getCheckpointTime(8)) / (speed - getTravellingSpeed(9));
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
	
	hidden function getCheckpointTime(interval) {
		return INTERVAL_TIME * (interval + 1);
	}
	
	hidden function getTravelling(interval) {
		return CAR_SPEED_ARRAY[interval] * METERS_IN_KILOMETER / 2;
	}
	
	hidden function getCheckpoint(interval) {
		var checkpoint = 0;
		for (var i = 1; i <= interval; i++) {
			checkpoint += getTravelling(interval);
		}
		return checkpoint;
	}
	
	hidden function getTravellingSpeed(interval) {
		return CAR_SPEED_ARRAY[interval] / KPS_IN_MPMS;
	}
	
	hidden function getTravellingDistance(time, checkpointTime, travellingSpeed, travelling) {
		var dist = 0;
		if (time > checkpointTime) {
			var intervalTime = time - checkpointTime;
			dist = intervalTime < INTERVAL_TIME
					? intervalTime * travellingSpeed
					: travelling;
		}
		return dist;
	}
	
	hidden function getFinishingDistance(time) {
		var dist = 0;
		if (time > getCheckpointTime(8)) {
			dist = (time - getCheckpointTime(8)) * getTravellingSpeed(9);
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