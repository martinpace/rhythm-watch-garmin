import Toybox.Attention;
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Sensor;

class rhythm_watch_garminView extends WatchUi.View {
    private var _accelData = [0, 0, 0];

    function initialize() {
        View.initialize();

        // Setup the Sensor Listener for High Frequency Data
        var options = {
            :period => 1,               // 1 second of data
            :accelerometer => {
                :enabled => true,
                :sampleRate => 25       // 25 samples per second
            }
        };

        try {
            Sensor.registerSensorDataListener(method(:onSensorData), options);
        } catch(e) {
            System.println("Sensor Error: " + e.getErrorMessage());
        }
    }

    private var _maxAccel = 0;

    // This function is called every time a new batch of data arrives
    function onSensorData(data as Sensor.SensorData) as Void {
        if (data.accelerometerData != null) {
            // Get the last sample in the batch for a quick PoC display
            var x = data.accelerometerData.x;
            // _accelData = [x[x.size()-1], 0, 0]; 
            for (var i = 0; i < x.size(); i++) {
                // Math.abs turns negative hits into positive force values
                var absoluteValue = x[i].abs();
                if (absoluteValue > _maxAccel) {
                    _maxAccel = absoluteValue;
                }
            }
            WatchUi.requestUpdate(); // Tell the watch to redraw the screen
        }
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

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(195, 150, Graphics.FONT_MEDIUM, "G-Force X:", Graphics.TEXT_JUSTIFY_CENTER);
        
        // Display the raw X-axis data (your arm's up/down movement)
        dc.drawText(195, 200, Graphics.FONT_NUMBER_MEDIUM, _maxAccel.toString(), Graphics.TEXT_JUSTIFY_CENTER);
    }

    function onHide() as Void {
    }
}