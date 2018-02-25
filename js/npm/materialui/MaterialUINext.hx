package js.npm.materialui;

/**
 * React js import hackery to this working
 * You'll need (in libs.js):
 * 'material-ui/styles/withTheme': require('material-ui/styles/withTheme'),
 */
@:jsRequire('material-ui/styles/withTheme', 'default')
class StylesWithTheme
{
	@:selfCall
	public static var call :Dynamic;
}

/**
 * React js import hackery to this working
 * See StylesWithTheme and add the modified entry in libs.js
 */
@:jsRequire('material-ui/styles/createMuiTheme', 'default')
class StylesCreateMuiTheme
{
	@:selfCall
	public static var call :Dynamic;
}

/**
 * React js import hackery to this working
 * See StylesWithTheme and add the modified entry in libs.js
 */
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
