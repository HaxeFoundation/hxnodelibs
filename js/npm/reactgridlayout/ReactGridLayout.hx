package js.npm.reactgridlayout;

/** https://github.com/STRML/react-grid-layout#responsive-usage */

typedef LayoutData = {
	@:optional var i :String;
	@:optional var x :Float;
	@:optional var y :Float;
	@:optional var w :Float;
	@:optional var h :Float;
	@:optional var minW :Float;
	@:optional var maxW :Float;
	@:optional var minH :Float;
	@:optional var maxH :Float;
	@:optional var isDraggable :Bool;
	@:optional var isResizable :Bool;
}

@:jsRequire('react-grid-layout')
extern class ReactGridLayout extends react.ReactComponent  { }

@:jsRequire('react-grid-layout', 'Responsive')
extern class ResponsiveReactGridLayout extends ReactGridLayout {}


@:jsRequire('react-grid-layout', 'WidthProvider')
extern class ReactGridWidthProvider extends ReactGridLayout
{
	@:selfCall
	public function new(cls :Class<ReactGridLayout>) :Void;
}

// class ReactGridWidthProviderImpl
// {
// 	public static var ResponsiveReactGridLayout :Class<react.ReactComponent> = cast new ReactGridWidthProvider(ReactGridResponsive);
// }
