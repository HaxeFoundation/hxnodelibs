package js.npm.clicolor;

@:jsRequire('cli-color')
extern class CliColor
{
	public static function bold(s :String) :String;
	public static function italic(s :String) :String;
	public static function underline(s :String) :String;
	public static function blink(s :String) :String;
	public static function inverse(s :String) :String;
	public static function strike(s :String) :String;

	public static function black(s :String) :String;
	public static function red(s :String) :String;
	public static function green(s :String) :String;
	public static function yellow(s :String) :String;
	public static function blue(s :String) :String;
	public static function magenta(s :String) :String;
	public static function cyan(s :String) :String;
	public static function white(s :String) :String;

	public static function blackBright(s :String) :String;
	public static function redBright(s :String) :String;
	public static function greenBright(s :String) :String;
	public static function yellowBright(s :String) :String;
	public static function blueBright(s :String) :String;
	public static function magentaBright(s :String) :String;
	public static function cyanBright(s :String) :String;
	public static function whiteBright(s :String) :String;

	public static function bgBlack(s :String) :String;
	public static function bgRed(s :String) :String;
	public static function bgGreen(s :String) :String;
	public static function bgYellow(s :String) :String;
	public static function bgBlue(s :String) :String;
	public static function bgMagenta(s :String) :String;
	public static function bgCyan(s :String) :String;
	public static function bgWhite(s :String) :String;

	public static function xterm(v :Int) :String->String;
	public static function bgXterm(v :Int) :String->String;

	public static function art(text :String, style :Dynamic) :String;

	public static var reset :String;
	public static var erase :{
		screenLeft :String,
		screenRight :String,
		line :String,
		lineRight :String,
		lineLeft :String,
	};
}