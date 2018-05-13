using Toybox.Test as Test;
using Toybox.Activity as Activity;

(:debug)
class CalculatorTest {

	hidden static var info;
	
	hidden static function generateInfo(distance, timeInMinutes) {
		info = new Activity.Info();
		info.elapsedDistance = distance;
		info.elapsedTime = timeInMinutes * MILLISECONDS_IN_MINUTE;
		info.averageSpeed = info.elapsedTime != 0 ? distance/info.elapsedTime * MILLISECONDS_IN_SECOND : 0.0f;
		return info;
	}

	(:test)
	static function inTheBeginning(logger) {
		return new Calculator().calculate(generateInfo(0.0f, 0), 0) == CHAMPION_FINISH;
	}
	
	(:test)
	static function after30MinutesRan0(logger) {
		return new Calculator().calculate(generateInfo(0.0f, 30), 0) == CHAMPION_FINISH;
	}
	
	(:test)
	static function after100MinutesRan0(logger) {
		var finish = new Calculator().calculate(generateInfo(0.0f, 100), 15000);
		Test.assertEqualMessage(0, finish, finish.toString());
		return true;
	}
	
	(:test)
	static function after42MinutesRan5Km(logger) {
		var finish = new Calculator().calculate(generateInfo(5000.0f, 45), 0);
		logger.debug(finish);
		return (6000.0f - finish).abs() < 1;
	}
	
	(:test)
	static function after60MinutesRan9Km(logger) {
		var finish = new Calculator().calculate(generateInfo(9000.0f, 60), 0);
		logger.debug(finish);
		return (11250.0f - finish).abs() < 1;
	}
	
	(:test)
	static function after90MinutesRan15Km(logger) {
		var finish = new Calculator().calculate(generateInfo(15000.0f, 90), 0);
		logger.debug(finish);
		return finish == 15000.0f;
	}
	
	(:test)
	static function after90MinutesRan175Km(logger) {
		var finish = new Calculator().calculate(generateInfo(17500.0f, 90), 0);
		logger.debug(finish);
		return (24231.0f - finish).abs() < 1;
	}
	
	(:test)
	static function after150MinutesRan31Km(logger) {
		var finish = new Calculator().calculate(generateInfo(31000.0f, 150), 0);
		logger.debug(finish);
		return finish == 31000.0f;
	}
	
	(:test)
	static function after150MinutesRan33Km(logger) {
		var finish = new Calculator().calculate(generateInfo(33000.0f, 150), 0);
		logger.debug(finish);
		return (39947.0f - finish).abs() < 1;
	}
	
	(:test)
	static function after210MinutesRan48Km(logger) {
		var finish = new Calculator().calculate(generateInfo(48000.0f, 210), 0);
		logger.debug(finish);
		return (48000.0f - finish).abs() < 1;
	}
	
	(:test)
	static function after210MinutesRan54Km(logger) {
		var finish = new Calculator().calculate(generateInfo(54000.0f, 210), 0);
		logger.debug(finish);
		return (74250.0f - finish).abs() < 1;
	}
	
	(:test)
	static function after330MinutesRan88Km(logger) {
		var finish = new Calculator().calculate(generateInfo(88000.0f, 330), 0);
		logger.debug(finish);
		return finish == 88000.0f;
	}
	
	(:test)
	static function after330MinutesRan93Km(logger) {
		var finish = new Calculator().calculate(generateInfo(93000.0f, 330), 0);
		logger.debug(finish);
		return (97673.0f - finish).abs() < 1;
	}
	
	(:test)
	static function after330MinutesRan99Km(logger) {
		var finish = new Calculator().calculate(generateInfo(99000.0f, 330), 0);
		logger.debug(finish);
		return finish == CHAMPION_FINISH;
	}
	
	(:test)
	static function afterCaught(logger) {
		var calculator = new Calculator();
		var finish = calculator.calculate(generateInfo(0, 90), 15000);
		logger.debug(finish);
		finish = calculator.calculate(generateInfo(50000, 150), 31000);
		Test.assertEqualMessage(0, finish, finish.toString());
		return true;
	}
}