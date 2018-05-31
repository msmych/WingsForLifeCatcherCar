using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class Dashboard extends Ui.Drawable {

	hidden const remainingTimeLabelText = "Remaining";
	hidden const finishLabelText = "Finish";

	hidden var layout = FULL;
	
	hidden var remainingTimeLabelX;
	hidden var finishLabelX;
	hidden var remainingTimeLabelY;
	hidden var finishLabelY;
	hidden var remainingTimeLabelJustification;
	hidden var finishLabelJustification;
	
	hidden var remainingTimeText = "0:00:00";
	
	hidden var remainingTimeTextX;
	hidden var finishTextX;
	hidden var remainingTimeTextY;
	hidden var finishTextY;
	hidden var remainingTimeTextJustification;
	hidden var finishTextJustification;
	
	hidden var finish = CHAMPION_FINISH;
	
	function initialize() {
		var settings = {
			:identifier => "Dashboard"
		};
		Drawable.initialize(settings);
	}
	
	function update(remainingTime, finished, estimatedFinish) {
		if (finished) {
			remainingTimeLabelText = "Finished";
		} else {
			var time = remainingTime.toNumber();
			var hours = time / MILLISECONDS_IN_HOUR;
			time -= hours * MILLISECONDS_IN_HOUR;
			var minutes = time / MILLISECONDS_IN_MINUTE;
			time -= minutes * MILLISECONDS_IN_MINUTE;
			var seconds = time / MILLISECONDS_IN_SECOND;
			remainingTimeText = hours
					+ ":" + (minutes < 10 ? "0" : "") + minutes
					+ ":" + (seconds < 10 ? "0" : "") + seconds;
		}
		finish = estimatedFinish;
	}
	
	function draw(dc) {
		if (isLargeEnoughForLabel(dc)) {
			dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
			setLabelsX(dc);
			setLabelsY(dc);
			setLabelsJustification();
			dc.drawText(remainingTimeLabelX, remainingTimeLabelY, Gfx.FONT_XTINY, remainingTimeLabelText, remainingTimeLabelJustification);
			dc.drawText(finishLabelX, finishLabelY, Gfx.FONT_XTINY, finishLabelText, finishLabelJustification);
		}
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		setTextsX(dc);
		setTextsY(dc);
		var textFontHeight = layout == SHORT and dc.getFontHeight(Gfx.FONT_LARGE)*2 > dc.getHeight()
				? Gfx.FONT_MEDIUM : Gfx.FONT_LARGE;
		setTextsJustification();
		dc.drawText(remainingTimeTextX, remainingTimeTextY, textFontHeight, remainingTimeText, remainingTimeTextJustification);
		dc.drawText(finishTextX, finishTextY, textFontHeight, (finish/METERS_IN_KILOMETER).format("%.2f"), finishTextJustification);
	}
	
	hidden function isLargeEnoughForLabel(dc) {
		switch (layout) {
			case SHORT:
			case TOP_RIGHT:
			case BOTTOM_RIGHT:
			case BOTTOM_LEFT:
			case TOP_LEFT:
				return false;
			case TOP:
			case BOTTOM:
				return dc.getHeight() >= dc.getFontHeight(Gfx.FONT_LARGE) + dc.getFontHeight(Gfx.FONT_XTINY)*2;
			default:
				return true;
		}
	}
	
	hidden function setLabelsX(dc) {
		switch (layout) {
			case TOP:
			case BOTTOM:
				remainingTimeLabelX = dc.getWidth()/2 + dc.getWidth()/25;
				finishLabelX = dc.getWidth()/2 + dc.getWidth()*2/25;
				break;
			default:
				remainingTimeLabelX = dc.getWidth()*1/4;
				finishLabelX = dc.getWidth()*3/4;
		}
	}
	
	hidden function setLabelsY(dc) {
		var y;
		switch (layout) {
			case TOP:
				y = dc.getHeight() - dc.getFontHeight(Gfx.FONT_LARGE) - dc.getFontHeight(Gfx.FONT_XTINY)/2;
				break;
			case BOTTOM:
				y = dc.getFontHeight(Gfx.FONT_LARGE) + dc.getFontHeight(Gfx.FONT_XTINY)/2;
				break;
			default:
				y = dc.getHeight()/2 - dc.getFontHeight(Gfx.FONT_LARGE)/2 - dc.getFontHeight(Gfx.FONT_XTINY)/2;
		}
		remainingTimeLabelY = y;
		finishLabelY = y;
	}
	
	hidden function setLabelsJustification() {
		switch (layout) {
			case TOP:
			case BOTTOM:
				remainingTimeLabelJustification = Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER;
				finishLabelJustification =  Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER;
				break;
			default:
				remainingTimeLabelJustification = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
				finishLabelJustification = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
		}
	}
	
	hidden function setTextsX(dc) {
		switch (layout) {
			case TOP_LEFT:
			case BOTTOM_LEFT:
				remainingTimeTextX = dc.getWidth()*24/25;
				finishTextX = dc.getWidth()*24/25;
				break;
			case TOP_RIGHT:
			case BOTTOM_RIGHT:
				remainingTimeTextX = dc.getWidth()/25;
				finishTextX = dc.getWidth()/25;
				break;
			case TOP:
			case BOTTOM:
				remainingTimeTextX = dc.getWidth()/2 + dc.getWidth()/25;
				finishTextX = dc.getWidth()/2 + dc.getWidth()*2/25;
				break;
			case SHORT:
				remainingTimeTextX = dc.getWidth()/2;
				finishTextX = dc.getWidth()/2;
				break;
			default:
				remainingTimeTextX = dc.getWidth()*1/4;
				finishTextX = dc.getWidth()*3/4;
		}
	}
	
	hidden function setTextsY(dc) {
		switch (layout) {
			case SHORT:
				if (dc.getFontHeight(Gfx.FONT_LARGE)*2 > dc.getHeight()) {
					remainingTimeTextY = dc.getHeight() - dc.getFontHeight(Gfx.FONT_MEDIUM)/2;
					finishTextY = dc.getHeight() - dc.getFontHeight(Gfx.FONT_MEDIUM)*3/2;
				} else {
					remainingTimeTextY = dc.getHeight() - dc.getFontHeight(Gfx.FONT_LARGE)/2;
					finishTextY = dc.getHeight() - dc.getFontHeight(Gfx.FONT_LARGE)*3/2;
				}
				break;
			case TOP_LEFT:
			case TOP_RIGHT:
				remainingTimeTextY = dc.getHeight() - dc.getFontHeight(Gfx.FONT_LARGE)/2;
				finishTextY = dc.getHeight() - dc.getFontHeight(Gfx.FONT_LARGE)*3/2;
				break;
			case TOP:
				remainingTimeTextY = dc.getHeight() - dc.getFontHeight(Gfx.FONT_LARGE)/2;
				finishTextY = dc.getHeight() - dc.getFontHeight(Gfx.FONT_LARGE)/2;
				break;
			case BOTTOM_LEFT:
			case BOTTOM_RIGHT:
				remainingTimeTextY = dc.getFontHeight(Gfx.FONT_LARGE)/2;
				finishTextY = dc.getFontHeight(Gfx.FONT_LARGE)*3/2;
				break;
			case BOTTOM:
				remainingTimeTextY = dc.getFontHeight(Gfx.FONT_LARGE)/2;
				finishTextY = dc.getFontHeight(Gfx.FONT_LARGE)/2;
				break;
			default:
				remainingTimeTextY = dc.getHeight()/2;
				finishTextY = dc.getHeight()/2;
		}
	}
	
	hidden function setTextsJustification() {
		switch (layout) {
			case TOP_RIGHT:
			case BOTTOM_RIGHT:
				remainingTimeTextJustification = Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER;
				finishTextJustification = Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER;
				break;
			case TOP_LEFT:
			case BOTTOM_LEFT:
				remainingTimeTextJustification = Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER;
				finishTextJustification = Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER;
				break;
			case TOP:
			case BOTTOM:
				remainingTimeTextJustification = Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER;
				finishTextJustification = Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER;
				break;
			default:
				remainingTimeTextJustification = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
				finishTextJustification = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
		}
	}
	
	function setLayout(newLayout) {
		layout = newLayout;
	}
}