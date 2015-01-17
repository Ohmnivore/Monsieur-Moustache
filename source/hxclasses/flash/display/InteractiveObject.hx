package flash.display;

extern class InteractiveObject extends DisplayObject {
	var accessibilityImplementation : flash.accessibility.AccessibilityImplementation;
	var contextMenu : flash.ui.ContextMenu;
	var doubleClickEnabled : Bool;
	var focusRect : Dynamic;
	var mouseEnabled : Bool;
	var tabEnabled : Bool;
	var tabIndex : Int;
	function new() : Void;
}
