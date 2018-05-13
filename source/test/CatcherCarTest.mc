using Toybox.Test as Test;
using Toybox.Activity as Activity;

(:debug)
class CatcherCarTest {

	hidden static var catcherCar;
	hidden static var info;
	
	hidden static function generateCatcherCar(timeInMinutes) {
		catcherCar = new CatcherCar();
		info = new Activity.Info();
		info.elapsedTime = timeInMinutes * MILLISECONDS_IN_MINUTE;
		catcherCar.update(info);
		return catcherCar;
	}
	
	(:test)
	static function inTheBeginning(logger) {
		var distance = generateCatcherCar(0).getDistance();
		Test.assertEqualMessage(0, distance, distance);
		return true;
	}
	
	(:test)
	static function after10Minutes(logger) {
		var distance = generateCatcherCar(0).getDistance();
		Test.assertEqualMessage(0, distance, distance);
		return true;
	}
	
	(:test)
	static function after30Minutes(logger) {
		return generateCatcherCar(30).getDistance() == 0.0f;
	}
	
	(:test)
	static function after50Minutes(logger) {
		var distance = generateCatcherCar(50).getDistance();
		logger.debug(distance);
		return distance.toNumber() == 5000;
	}
	
	(:test)
	static function after70Minutes(logger) {
		var distance = generateCatcherCar(70).getDistance();
		logger.debug(distance);
		return distance.toNumber() == 10000;
	}
	
	(:test)
	static function after90Minutes(logger) {
		var distance = generateCatcherCar(90).getDistance();
		logger.debug(distance);
		return distance == 15000.0f;
	}
	
	(:test)
	static function after105Minutes(logger) {
		var distance = generateCatcherCar(105).getDistance();
		logger.debug(distance);
		return distance == 19000.0f;
	}
	
	(:test)
	static function after150Minutes(logger) {
		var distance = generateCatcherCar(150).getDistance();
		logger.debug(distance);
		return distance == 31000.0f;
	}
	
	(:test)
	static function after180Minutes(logger) {
		var distance = generateCatcherCar(180).getDistance();
		logger.debug(distance);
		return distance == 39500.0f;
	}
	
	(:test)
	static function after210Minutes(logger) {
		var distance = generateCatcherCar(210).getDistance();
		logger.debug(distance);
		return distance == 48000.0f;
	}
	
	(:test)
	static function after270Minutes(logger) {
		var distance = generateCatcherCar(270).getDistance();
		logger.debug(distance);
		return distance == 68000.0f;
	}
	
	(:test)
	static function after330Minutes(logger) {
		var distance = generateCatcherCar(330).getDistance();
		logger.debug(distance);
		return distance == 88000.0f;
	}
	
	(:test)
	static function after342Minutes(logger) {
		var distance = generateCatcherCar(342).getDistance();
		logger.debug(distance);
		return distance == 95000.0f;
	}
	
	(:test)
	static function after390Minutes(logger) {
		var distance = generateCatcherCar(390).getDistance();
		logger.debug(distance);
		return distance == 123000.0f;
	}
}