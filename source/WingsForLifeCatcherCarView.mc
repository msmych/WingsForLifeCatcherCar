using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Activity as Activity;

class WingsForLifeCatcherCarView extends Ui.DataField {

    hidden var info = new Activity.Info();

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
    function compute(activityInfo) {
		info = activityInfo;
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc) {
        var catcherCarView = View.findDrawableById("CatcherCar");
        catcherCarView.update(info);
        var catcherCarDistance = catcherCarView.getDistance();
        var finish = View.findDrawableById("Calculator").calculate(info, catcherCarDistance);
        catcherCarView.setFinish(finish);
        var runnerView = View.findDrawableById("Runner");
        runnerView.update(info, finish);
        catcherCarView.setDistanceFromRunner(runnerView.getDistance());

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

}
