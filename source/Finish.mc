using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class Finish extends Ui.Drawable {
	
	hidden var finish = CHAMPION_FINISH;
	
	hidden var layout = WingsForLifeCatcherCarView.FULL;
	
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
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		dc.drawText(
				getTextX(dc),
				getTextY(dc),
				Gfx.FONT_LARGE,
				(finish/METERS_IN_KILOMETER).format("%.2f"),
				getTextJustification());
	}
	
	hidden function getTextX(dc) {
		switch (layout) {
			case WingsForLifeCatcherCarView.TOP:
			case WingsForLifeCatcherCarView.BOTTOM:
				return dc.getWidth()/2 + dc.getWidth()*2/25;
			default:
				return dc.getWidth()*3/4;
		}
	}
	
	hidden function getTextY(dc) {
		switch (layout) {
			case WingsForLifeCatcherCarView.TOP:
				return dc.getHeight() - dc.getFontHeight(Gfx.FONT_LARGE)/2;
			case WingsForLifeCatcherCarView.BOTTOM:
				return dc.getFontHeight(Gfx.FONT_LARGE)/2;
			default:
				return dc.getHeight()/2;
		}
	}
	
	hidden function getTextJustification() {
		switch (layout) {
			case WingsForLifeCatcherCarView.TOP:
			case WingsForLifeCatcherCarView.BOTTOM:
				return Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER;
			default:
				return Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;
		}
	}
	
	function setLayout(newLayout) {
		layout = newLayout;
	}
}