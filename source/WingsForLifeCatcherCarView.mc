using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Activity as Activity;

class WingsForLifeCatcherCarView extends Ui.DataField {

    hidden var calculator = new Calculator();

    function initialize() {
        DataField.initialize();
    }

    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc) {
        View.setLayout(Rez.Layouts.MainLayout(dc));

        return true;
    }

    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info) {
		calculator.calculate(info);
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc) {
    	var runnerDistance = calculator.getRunnerDistance();
    	var finish = calculator.getFinish();
        View.findDrawableById("CatcherCar").update(calculator.getCatcherCarDistance(), runnerDistance, finish);
        View.findDrawableById("Runner").update(runnerDistance, finish);
        View.findDrawableById("RemainingTime").update(calculator.getRemainingTime(), calculator.isFinished());
        View.findDrawableById("Finish").update(finish);

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

}
