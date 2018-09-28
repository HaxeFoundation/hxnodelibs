package js.npm.express;

/**
 * Global context class for expressjs features.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:jsRequire("express")
extern class Express
{
	/**
	 * Create an express application.
	 */
	@:deprecated("Use `new js.npm.express.Application()` instead")
	inline static public function GetApplication():Application { return new Application(); }
	
	/**
	 * Create a new router by using "express.Router()"
	 */
	@:deprecated("Use `new js.npm.express.Router()` instead")
	inline static public function GetRouter(p_case_sensitive:Bool=false, p_strict : Bool=false):Router 
	{ 
		var opt:Dynamic = { }; 
		opt.caseSensitive = p_case_sensitive; 
		opt.strict = p_strict;  
		return new Router(opt); 
	}

	@:native("static")
	static public function Static(root:String, ?options:{
		?dotfiles : String,
		?etag : Bool,
		?extensions : Bool,
		?fallthrough : Bool,
		?immutable : Bool,
		?index : Dynamic,
		?lastModified : Bool,
		?maxAge : Int,
		?redirect : Bool,
		?setHeaders : ExpressResponse -> String -> js.node.fs.Stats -> Void
	}):haxe.Constraints.Function;
}