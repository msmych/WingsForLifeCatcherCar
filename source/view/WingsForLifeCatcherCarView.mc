using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Activity as Activity;

class WingsForLifeCatcherCarView extends Ui.DataField {

	enum {
		FULL,
		ROUND,
		TOP,
		BOTTOM,
		TOP_RIGHT,
		BOTTOM_RIGHT,
		BOTTOM_LEFT,
		TOP_LEFT,
		SHORT
	}
	
	hidden var layout = FULL;

    hidden var calculator = new Calculator();

    function initialize() {
        DataField.initialize();
    }

    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc) {
    	
    	switch (DataField.getObscurityFlags()) {
    		case OBSCURE_TOP + OBSCURE_BOTTOM + OBSCURE_LEFT + OBSCURE_RIGHT:
    			layout = ROUND;
    			View.setLayout(Rez.Layouts.RoundLayout(dc));
    			break;
    		case OBSCURE_TOP + OBSCURE_LEFT + OBSCURE_RIGHT:
    			layout = TOP;
    			View.setLayout(Rez.Layouts.MainLayout(dc));
    			break;
    		case OBSCURE_BOTTOM + OBSCURE_LEFT + OBSCURE_RIGHT:
    			layout = BOTTOM;
    			View.setLayout(Rez.Layouts.RoundLayout(dc));
    			break;
    		case OBSCURE_TOP + OBSCURE_RIGHT:
    			layout = TOP_RIGHT;
    			View.setLayout(Rez.Layouts.MainLayout(dc));
    			break;
    		case OBSCURE_BOTTOM + OBSCURE_RIGHT:
    			layout = BOTTOM_RIGHT;
    			View.setLayout(Rez.Layouts.MainLayout(dc));
    			break;
    		case OBSCURE_BOTTOM + OBSCURE_LEFT:
    			layout = BOTTOM_LEFT;
    			View.setLayout(Rez.Layouts.MainLayout(dc));
    			break;
    		case OBSCURE_TOP + OBSCURE_LEFT:
    			layout = TOP_LEFT;
    			View.setLayout(Rez.Layouts.MainLayout(dc));
    			break;
    		default:
    			layout = dc.getWidth() >=
    					dc.getTextWidthInPixels("0:00:00", Gfx.FONT_LARGE)
    					+ dc.getTextWidthInPixels("100.00", Gfx.FONT_LARGE)
    					? FULL : SHORT;
    			View.setLayout(Rez.Layouts.MainLayout(dc));
    	}

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
    	
    	var catcherCarView = View.findDrawableById("CatcherCar");
    	catcherCarView.setLayout(layout);
        catcherCarView.update(calculator.getCatcherCarDistance(), runnerDistance, finish);
        
        var runnerView = View.findDrawableById("Runner");
        runnerView.setLayout(layout);
        runnerView.update(runnerDistance, finish);
        
        var remainingTimeView = View.findDrawableById("RemainingTime");
        remainingTimeView.setLayout(layout);
        remainingTimeView.update(calculator.getRemainingTime(), calculator.isFinished());
        
        var finishView = View.findDrawableById("Finish");
        finishView.setLayout(layout);
        finishView.update(finish);

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

}
