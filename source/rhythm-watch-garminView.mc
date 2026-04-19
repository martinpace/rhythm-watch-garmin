import Toybox.Attention;
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class rhythm_watch_garminView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        // We are bypassing the XML layout for this PoC to draw directly to the screen
    }

    function onShow() {
    if (Attention has :vibrate) {
        var vibeProfile = [
            new Attention.VibeProfile(50, 100), // 50% duty cycle, 100ms
            new Attention.VibeProfile(0, 100),  // Pause 100ms
            new Attention.VibeProfile(100, 100) // 100% duty cycle, 100ms
        ];
        Attention.vibrate(vibeProfile);
    }
}

    function onUpdate(dc as Dc) as Void {
        // 1. Clear the screen (Crucial for AMOLED to save battery & prevent ghosting)
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        // 2. Set the "Pen" color for your text
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        // 3. Get screen dimensions (Forerunner 165 is 390x390)
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;

        // 4. Draw the Title
        dc.drawText(
            centerX, 
            centerY - 30, 
            Graphics.FONT_MEDIUM, 
            "RHYTHM WATCH", 
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // 5. Draw the Subtitle/Status
        // We'll use a specific color to verify color rendering on the AMOLED
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX, 
            centerY + 20, 
            Graphics.FONT_SMALL, 
            "PoC ACTIVE", 
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }

    function onHide() as Void {
    }
}