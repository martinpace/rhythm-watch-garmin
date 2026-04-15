import Toybox.Lang;
import Toybox.WatchUi;

class rhythm_watch_garminDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new rhythm_watch_garminMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}