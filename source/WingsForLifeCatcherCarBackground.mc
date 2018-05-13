using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class Background extends Ui.Drawable {

    hidden var mColor = Gfx.COLOR_BLACK;

    function initialize() {
        var dictionary = {
            :identifier => "Background"
        };

        Drawable.initialize(dictionary);
    }

    function setColor(color) {
        mColor = color;
    }

    function draw(dc) {
        dc.setColor(Gfx.COLOR_TRANSPARENT, mColor);
        dc.clear();
    }

}
