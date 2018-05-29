using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class Finish extends Ui.Drawable {

	hidden const labelText = "Finish";
	
	hidden var finish = CHAMPION_FINISH;
	
	hidden var layout = FULL;
	
	function initialize() {
		var settings = {
			:identifier => "Finish"
		};
		Drawable.initialize(settings);
	}
	
	function update(estimatedFinish) {
		finish = estimatedFinish;
	}
	
	function draw(dc) {
		if (isLargeEnoughForLabel(dc)) {		
			drawLabel(dc);
		}
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		dc.drawText(
				getTextX(dc),
				getTextY(dc),
				getTextFont(dc),
				(finish/METERS_IN_KILOMETER).format("%.2f"),
				getTextJustification());
	}
	
	hidden function isLargeEnoughForLabel(dc) {
		switch (layout) {
			case TOP_RIGHT:
			case BOTTOM_RIGHT:
			case BOTTOM_LEFT:
			case TOP_LEFT:
			case SHORT:
				return false;
			case TOP:
			case BOTTOM:
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
			case TOP:
			case BOTTOM:
				return dc.getWidth()/2 + dc.getWidth()*2/25;
			case ROUND:
			default:
				return dc.getWidth()*3/4;
		}
	}
	
	hidden function getLabelY(dc) {
		switch (layout) {
			case TOP:
				return dc.getHeight() - dc.getFontHeight(Gfx.FONT_LARGE) - dc.getFontHeight(Gfx.FONT_XTINY)/2;
			case BOTTOM:
				return dc.getFontHeight(Gfx.FONT_LARGE) + dc.getFontHeight(Gfx.FONT_XTINY)/2;
			case ROUND:
			default:
				return dc.getHeight()/2 - dc.getFontHeight(Gfx.FONT_LARGE)/2 - dc.getFontHeight(Gfx.FONT_XTINY)/2;
		}
	}
	
	hidden function getLabelJustification() {
		switch (layout) {
			case TOP:
			case BOTTOM:
				return Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER;
			case ROUND:
			default:
				return Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
		}
	}
	
	hidden function getTextX(dc) {
		switch (layout) {
			case TOP_LEFT:
			case BOTTOM_LEFT:
				return dc.getWidth()*24/25;
			case TOP_RIGHT:
			case BOTTOM_RIGHT:
				return dc.getWidth()/25;
			case TOP:
			case BOTTOM:
				return dc.getWidth()/2 + dc.getWidth()*2/25;
			case SHORT:
				return dc.getWidth()/2;
			default:
				return dc.getWidth()*3/4;
		}
	}
	
	hidden function getTextY(dc) {
		switch (layout) {
			case SHORT:
				if (dc.getFontHeight(Gfx.FONT_LARGE)*2 > dc.getHeight()) {
					return dc.getHeight() - dc.getFontHeight(Gfx.FONT_MEDIUM)*3/2;
				}
			case TOP_LEFT:
			case TOP_RIGHT:
				return dc.getHeight() - dc.getFontHeight(Gfx.FONT_LARGE)*3/2;
			case BOTTOM_LEFT:
			case BOTTOM_RIGHT:
				return dc.getFontHeight(Gfx.FONT_LARGE)*3/2;
			case TOP:
				return dc.getHeight() - dc.getFontHeight(Gfx.FONT_LARGE)/2;
			case BOTTOM:
				return dc.getFontHeight(Gfx.FONT_LARGE)/2;
			default:
				return dc.getHeight()/2;
		}
	}
	
	hidden function getTextFont(dc) {
		switch (layout) {
			case SHORT:
				if (dc.getFontHeight(Gfx.FONT_LARGE)*2 > dc.getHeight()) {
					return Gfx.FONT_MEDIUM;
				}
			default:
				return Gfx.FONT_LARGE;
		}
	}
	
	hidden function getTextJustification() {
		switch (layout) {
			case TOP_LEFT:
			case BOTTOM_LEFT:
				return Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER;
			case TOP_RIGHT:
			case BOTTOM_RIGHT:
			case TOP:
			case BOTTOM:
				return Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER;
			default:
				return Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
		}
	}
	
	function setLayout(newLayout) {
		layout = newLayout;
	}
}