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
	static function inTheBeginning(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(0.0f, 0));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(0, catcherCarDistance, catcherCarDistance);
		var finish = calculator.getFinish();
		Test.assertEqualMessage(CHAMPION_FINISH, finish, finish);
		return true;
	}
	
	(:test)
	static function after10Minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(2000, 0));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(0, catcherCarDistance, catcherCarDistance);
		return true;
	}
	
	(:test)
	static function after30MinutesRan0(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(0, 30));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(0, catcherCarDistance, catcherCarDistance);
		var finish = calculator.getFinish();
		Test.assertEqualMessage(CHAMPION_FINISH, finish, finish);
		return true;
	}
	
	(:test)
	static function after50Minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(8000, 50));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(5000, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function after70Minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(11000, 70));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(10000, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function after90Minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(16000, 90));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(15000, catcherCarDistance, catcherCarDistance);
		return true;
	}
	
	(:test)
	static function after100MinutesRan0(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(0, 100));
		var finish = calculator.getFinish();
		Test.assertEqualMessage(0, finish, finish.toString());
		return true;
	}
	
	(:test)
	static function after105Minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(20000, 105));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(19000, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function after42MinutesRan5Km(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(5000.0f, 45));
		var finish = calculator.getFinish();
		logger.debug(finish);
		Test.assert((6000 - finish).abs() < 1);
		return true;
	}
	
	(:test)
	static function after60MinutesRan9Km(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(9000.0f, 60));
		var finish = calculator.getFinish();
		logger.debug(finish);
		Test.assert((11250 - finish).abs() < 1);
		return true;
	}
	
	(:test)
	static function after90MinutesRan15Km(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(15000.0f, 90));
		var finish = calculator.getFinish();
		Test.assertEqualMessage(15000.0f, finish, finish);
		return true;
	}
	
	(:test)
	static function after90MinutesRan175Km(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(17500.0f, 90));
		var finish = calculator.getFinish();
		logger.debug(finish);
		Test.assert((24231 - finish).abs() < 1);
		return true;
	}
	
	(:test)
	static function after150MinutesRan31Km(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(31000, 150));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(31000, catcherCarDistance, catcherCarDistance);
		var finish = calculator.getFinish();
		Test.assertEqualMessage(31000.0f, finish, finish);
		return true;
	}
	
	(:test)
	static function after150MinutesRan33Km(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(33000.0f, 150));
		var finish = calculator.getFinish();
		logger.debug(finish);
		Test.assert((39947 - finish).abs() < 1);
		return true;
	}
	
	(:test)
	static function after180Minutes(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(40000, 180));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(39500, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function after210MinutesRan48Km(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(48000.0f, 210));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(48000, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		var finish = calculator.getFinish();
		logger.debug(finish);
		Test.assert((48000 - finish).abs() < 1);
		return true;
	}
	
	(:test)
	static function after210MinutesRan54Km(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(54000.0f, 210));
		var finish = calculator.getFinish();
		logger.debug(finish);
		Test.assert((74250 - finish).abs() < 1);
		return true;
	}
	
	(:test)
	static function after270MinutesRan70Km(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(70000, 270));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(68000, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function after330MinutesRan88Km(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(88000.0f, 330));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(88000, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		var finish = calculator.getFinish();
		Test.assertEqualMessage(88000.0f, finish, finish.toString());
		return true;
	}
	
	(:test)
	static function after330MinutesRan93Km(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(93000.0f, 330));
		var finish = calculator.getFinish();
		logger.debug(finish);
		Test.assert((97673 - finish).abs() < 1);
		return true;
	}
	
	(:test)
	static function after330MinutesRan99Km(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(99000.0f, 330));
		var finish = calculator.getFinish();
		Test.assertEqualMessage(CHAMPION_FINISH, finish, finish);
		return true;
	}
	
	(:test)
	static function after342MinutesRan98Km(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(98000, 342));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(95000, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function after390MinutesRan125Km(logger) {
		var calculator = new Calculator();
		calculator.calculate(generateInfo(125000, 390));
		var catcherCarDistance = calculator.getCatcherCarDistance();
		Test.assertEqualMessage(123000, catcherCarDistance.toNumber(), catcherCarDistance.toString());
		return true;
	}
	
	(:test)
	static function afterFinished(logger) {
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