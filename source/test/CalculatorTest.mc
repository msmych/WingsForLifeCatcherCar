using Toybox.Test as Test;
using Toybox.Activity as Activity;

(:debug)
class CalculatorTest {
	
	hidden static function generateInfo(distance, timeInMinutes) {
		var info = new Activity.Info();
		info.elapsedDistance = distance;
		info.elapsedTime = timeInMinutes * MILLISECONDS_IN_MINUTE;
		info.averageSpeed = info.elapsedTime != 0 ? distance/info.elapsedTime * MILLISECONDS_IN_SECOND : 0;
		return info;
	}

	(:test)
	static function in_the_beginning(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(0.0f, 0));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(0, catcherCarDistance, catcherCarDistance);
		var finish = calculator.getFinish();
		Test.assertEqualMessage(CHAMPION_FINISH, finish, finish);
		return true;
	}
	
	(:test)
	static function after_10_minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(2000, 0));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(0, catcherCarDistance, catcherCarDistance);
		return true;
	}
	
	(:test)
	static function after_30_minutes_ran_0(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(0, 30));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(0, catcherCarDistance, catcherCarDistance);
		var finish = calculator.getFinish();
		Test.assertEqualMessage(CHAMPION_FINISH, finish, finish);
		return true;
	}
	
	(:test)
	static function after_45_minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(8000, 45));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		logger.debug(catcherCarDistance);
		Test.assertEqualMessage(3500, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function after_80_minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(11000, 80));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		logger.debug(catcherCarDistance);
		Test.assertEqualMessage(12000, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function after_105_minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(20000, 105));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		logger.debug(catcherCarDistance);
		Test.assertEqualMessage(18500, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function after_150_minutes_ran_31_km(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(31000, 150));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(31000, catcherCarDistance, catcherCarDistance);
		var finish = calculator.getFinish();
		Test.assertEqualMessage(31000.0f, finish, finish);
		return true;
	}
	
	(:test)
	static function after_135_minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(40000, 135));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		logger.debug(catcherCarDistance);
		Test.assertEqualMessage(26750, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function after_165_minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(40000, 165));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		logger.debug(catcherCarDistance);
		Test.assertEqualMessage(35500, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function after_195_minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(40000, 195));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		logger.debug(catcherCarDistance);
		Test.assertEqualMessage(45500, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function after_225_minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(40000, 225));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		logger.debug(catcherCarDistance);
		Test.assertEqualMessage(57500, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function after_255_minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(40000, 255));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		logger.debug(catcherCarDistance);
		Test.assertEqualMessage(71500, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function after_285_minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(40000, 285));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		logger.debug(catcherCarDistance);
		Test.assertEqualMessage(87500, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function after_finished(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(0, 90));
		var finish = calculator.getFinish();
		logger.debug(finish);
		calculator.calculate(generateInfo(50000, 150));
		finish = calculator.getFinish();
		Test.assertEqualMessage(0, finish, finish.toString());
		return true;
	}
}