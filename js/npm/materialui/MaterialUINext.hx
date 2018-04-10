package js.npm.materialui;

/**
 * Incomplete
 */

@:jsRequire('material-ui/styles/withTheme', 'default')
class StylesWithTheme
{
	@:selfCall
	public static var call :Dynamic;
}

@:jsRequire('material-ui/styles/createMuiTheme', 'default')
class StylesCreateMuiTheme
{
	@:selfCall
	public static var call :Dynamic;
}

@:jsRequire('material-ui/styles/withStyles', 'default')
class StylesWithStyles
{
	@:selfCall
	public static var call :Dynamic;
}

@:jsRequire('material-ui/styles/withStyles', 'default')
class Styles
{
	public static var withStyles :Dynamic = Reflect.field(js.Lib.require('material-ui/styles/withStyles'), 'default');
	public static var createMuiTheme :Dynamic = Reflect.field(js.Lib.require('material-ui/styles/createMuiTheme'), 'default');
	public static var withTheme :Dynamic = Reflect.field(js.Lib.require('material-ui/styles/withTheme'), 'default');
}
