using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class RemainingTime extends Ui.Drawable {

	hidden const labelText = "Remaining";

	hidden var text = "0:00:00";
	
	hidden var layout = WingsForLifeCatcherCarView.FULL;
	
	function initialize() {
		var settings = {
			:identifier => "RemainingTime"
		};
		
		Drawable.initialize(settings);
	}
	
	function update(remainingTime, finished) {
		if (finished) {
			text = "Finished";
		} else {
			var time = remainingTime.toNumber();
			var hours = time / MILLISECONDS_IN_HOUR;
			time -= hours * MILLISECONDS_IN_HOUR;
			var minutes = time / MILLISECONDS_IN_MINUTE;
			time -= minutes * MILLISECONDS_IN_MINUTE;
			var seconds = time / MILLISECONDS_IN_SECOND;
			text = hours
					+ ":" + (minutes < 10 ? "0" : "") + minutes
					+ ":" + (seconds < 10 ? "0" : "") + seconds;
		}
	}
	
	function draw(dc) {
		if (isLargeEnough(dc)) {
			drawLabel(dc);
		}
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		dc.drawText(
				getTextX(dc),
				getTextY(dc),
				Gfx.FONT_LARGE,
				text,
				getTextJustification());
	}
	
	hidden function isLargeEnough(dc) {
		switch (layout) {
			case WingsForLifeCatcherCarView.TOP_RIGHT:
			case WingsForLifeCatcherCarView.BOTTOM_RIGHT:
			case WingsForLifeCatcherCarView.BOTTOM_LEFT:
			case WingsForLifeCatcherCarView.TOP_LEFT:
				return false;
			case WingsForLifeCatcherCarView.TOP:
			case WingsForLifeCatcherCarView.BOTTOM:
				return dc.getHeight() >= dc.getFontHeight(Gfx.FONT_LARGE) + dc.getFontHeight(Gfx.FONT_XTINY)*2;
			default:
				return true;
		}
	}
	
	hidden function drawLabel(dc) {
		dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
		dc.drawText(
				getLabelX(dc),
				getLabelY(dc),
				Gfx.FONT_XTINY,
				labelText,
				getLabelJustification());
	}
	
	hidden function getLabelX(dc) {
		switch (layout) {
			case WingsForLifeCatcherCarView.TOP:
			case WingsForLifeCatcherCarView.BOTTOM:
				return dc.getWidth()/2 + dc.getWidth()/25;
			case WingsForLifeCatcherCarView.ROUND:
			default:
				return dc.getWidth()*1/4;
		}
	}
	
	hidden function getLabelY(dc) {
		switch (layout) {
			case WingsForLifeCatcherCarView.TOP:
				return dc.getHeight() - dc.getFontHeight(Gfx.FONT_LARGE) - dc.getFontHeight(Gfx.FONT_XTINY)/2;
			case WingsForLifeCatcherCarView.BOTTOM:
				return dc.getFontHeight(Gfx.FONT_LARGE) + dc.getFontHeight(Gfx.FONT_XTINY)/2;
			case WingsForLifeCatcherCarView.ROUND:
			default:
				return dc.getHeight()/2 - dc.getFontHeight(Gfx.FONT_LARGE)/2 - dc.getFontHeight(Gfx.FONT_XTINY)/2;
		}
	}
	
	hidden function getLabelJustification() {
		switch (layout) {
			case WingsForLifeCatcherCarView.TOP:
			case WingsForLifeCatcherCarView.BOTTOM:
				return Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER;
			case WingsForLifeCatcherCarView.ROUND:
			default:
				return Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
		}
	}
	
	hidden function getTextX(dc) {
		switch (layout) {
			case WingsForLifeCatcherCarView.TOP_LEFT:
			case WingsForLifeCatcherCarView.BOTTOM_LEFT:
				return dc.getWidth()*24/25;
			case WingsForLifeCatcherCarView.TOP_RIGHT:
			case WingsForLifeCatcherCarView.BOTTOM_RIGHT:
				return dc.getWidth()/25;
			case WingsForLifeCatcherCarView.TOP:
			case WingsForLifeCatcherCarView.BOTTOM:
				return dc.getWidth()/2 + dc.getWidth()/25;
			default:
				return dc.getWidth()*1/4;
		}
	}
	
	hidden function getTextY(dc) {
		switch (layout) {
			case WingsForLifeCatcherCarView.TOP_LEFT:
			case WingsForLifeCatcherCarView.TOP_RIGHT:
			case WingsForLifeCatcherCarView.TOP:
				return dc.getHeight() - dc.getFontHeight(Gfx.FONT_LARGE)/2;
			case WingsForLifeCatcherCarView.BOTTOM_LEFT:
			case WingsForLifeCatcherCarView.BOTTOM_RIGHT:
			case WingsForLifeCatcherCarView.BOTTOM:
				return dc.getFontHeight(Gfx.FONT_LARGE)/2;
			default:
				return dc.getHeight()/2;
		}
	}
	
	hidden function getTextJustification() {
		switch (layout) {
			case WingsForLifeCatcherCarView.TOP_RIGHT:
			case WingsForLifeCatcherCarView.BOTTOM_RIGHT:
				return Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER;
			case WingsForLifeCatcherCarView.TOP_LEFT:
			case WingsForLifeCatcherCarView.BOTTOM_LEFT:
			case WingsForLifeCatcherCarView.TOP:
			case WingsForLifeCatcherCarView.BOTTOM:
				return Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER;
			default:
				return Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
		}
	}
	
	function setLayout(newLayout) {
		layout = newLayout;
	}
}