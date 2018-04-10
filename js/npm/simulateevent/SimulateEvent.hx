package js.npm.simulateevent;

import js.html.DOMElement;
import js.html.Event;

@:jsRequire("simulate-event")
extern class SimulateEvent
{
	public static function simulate(element :DOMElement, event :String, ?options :Dynamic) :Void;
	public static function generate(event :String, ?options :Dynamic) :Event;
}