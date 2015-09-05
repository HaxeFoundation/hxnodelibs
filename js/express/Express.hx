package js.node.express;

/**
 * Global context class for expressjs features.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
class Express
{
	
	/**
	 * Create an express application.
	 * @return
	 */
	static public function GetApplication():Application { return untyped __js__("require('express')()"); }
	
	/**
	 * Create a new router by using "express.Router()"
	 * @param	p_options
	 * @return
	 */	
	static public function GetRouter(p_case_sensitive:Bool=false, p_strict : Bool=false):Router 
	{ 
		var opt:Dynamic = { }; 
		opt.caseSensitive = p_case_sensitive; 
		opt.strict = p_strict;  
		return untyped __js__("require('express').Router(opt)"); 
	}
	
	/**
	 * 
	 * @param	p_value
	 * @return
	 */
	static public function Static(p_value : String):Dynamic { return untyped __js__("(require('express')).static(p_value)"); }
	
}