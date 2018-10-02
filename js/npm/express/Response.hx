package js.npm.express;
import haxe.Constraints;
import haxe.extern.EitherType;
import js.Error;

typedef CookieOptions = {
	@:optional var domain:String;
	@:optional var encode:Function;
	@:optional var expires:Dynamic;
	@:optional var httpOnly:Bool;
	@:optional var maxAge:Float;
	@:optional var path:String;
	@:optional var secure:Bool;
	@:optional var signed:Bool;
	@:optional var sameSite:EitherType<Bool, String>;
};

/**
 * http://expressjs.com/4x/api.html#res.status
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern  class Response implements Dynamic
{
	
	/**
	 * Response local variables are scoped to the request, thus only available to the view(s) rendered during that request / response cycle, if any. Otherwise this API is identical to app.locals.
	 * This object is useful for exposing request-level information such as the request pathname, authenticated user, user settings etcetera.
	 */
	var locals : Dynamic;
	
	/**
	 * Chainable alias of node's res.statusCode=.
	 * @param	p_code
	 * @return
	 */
	function status(p_code:Int):Response;
	
	/**
	 * Set header field to value, or pass an object to set multiple fields at once.
	 * @param	p_field
	 * @param	p_value
	 */
	@:overload(function(p_field:Dynamic):Void{})	
	function set(p_field:String, p_value:String):Void;
	
	/**
	 * Get the case-insensitive response header field.
	 * @param	p_field
	 * @return
	 */
	function get(p_field:String):String;
	
	
	/**
	 * Set cookie name to value, which may be a string or object converted to JSON. 
	 * The path option defaults to "/".
	 * The maxAge option is a convenience option for setting "expires" relative to the current time in milliseconds.
	 */
	function cookie(name:String, value:String, ?options:CookieOptions):Void;
	
	/**
	 * Clear cookie name. The path option defaults to "/".
	 */
	function clearCookie(name:String, ?options:CookieOptions):Void;
	
	/**
	 * Redirect to the given url with optional status code defaulting to 302 "Found".
	 * @param	p_status
	 * @param	p_url
	 */
	@:overload(function(p_url:String):Void { } )		
	function redirect(p_status:Int,p_url:String):Void;
	
	/**
	 * Set the location header.
	 * @param	p_location
	 */
	function location(p_location:String):Void;
	
	/**
	 * Send a response.
	 * @param	p_status
	 * @param	p_body
	 */
	@:overload(function(p_data:Dynamic):Void { } )	
	function send(p_body_or_status:Dynamic, p_body : Dynamic):Void;
	
	/**
	 * Send a JSON response. 
	 * This method is identical to res.send() when an object or array is passed, however it may be used for explicit JSON conversion of non-objects (null, undefined, etc), though these are technically not valid JSON.
	 * @param	p_body_or_status
	 * @param	p_body
	 */
	@:overload(function(p_data:Dynamic):Void { } )		
	function json(p_body_or_status:Dynamic, p_body : Dynamic):Void;
	
	/**
	 * Send a JSON response with JSONP support. This method is identical to res.json() however opts - in to JSONP callback support.
	 * @param	p_body_or_status
	 * @param	p_body
	 */
	@:overload(function(p_data:Dynamic):Void { } )			
	function jsonp(p_body_or_status:Dynamic, p_body : Dynamic):Void;
	
	
	/**
	 * Sets the Content-Type to the mime lookup of type, or when "/" is present the Content-Type is simply set to this literal value.
	 * @param	p_type
	 */
	function type(p_type:String):Void;
	
	/**
	 * Performs content-negotiation on the request Accept header field when present. This method uses req.accepted, an array of acceptable types ordered by their quality values, otherwise the first callback is invoked. When no match is performed the server responds with 406 "Not Acceptable", or invokes the default callback.
	 * The Content-Type is set for you when a callback is selected, however you may alter this within the callback using res.set() or res.type() etcetera.
	 * @param	p_object
	 */
	function format(p_object : Dynamic):Void;
	
	
	/**
	 * Sets the Content-Disposition header field to "attachment". If a filename is given then the Content-Type will be automatically set based on the extname via res.type(), and the Content-Disposition's "filename=" parameter will be set.
	 * @param	p_filename
	 */
	@:overload(function():Void{})
	function attachment(p_filename:String):Void;
	
	/**
	 * Transfer the file at the given path.
	 * Automatically defaults the Content-Type response header field based on the filename's extension.
	 * The callback fn(err) is invoked when the transfer is complete or when an error occurs.
	 * @param	p_path
	 * @param	p_options
	 * @param	p_fn
	 */
	@:overload(function(p_path:String):Void{})
	@:overload(function(p_path:String,p_options:Dynamic):Void{})
	function sendfile(p_path:String, p_options:Dynamic, p_fn: Error -> Void):Void;
	
	/**
	 * Transfer the file at path as an "attachment", typically browsers will prompt the user for download. 
	 * The Content-Disposition "filename=" parameter, aka the one that will appear in the brower dialog is set to path by default, however you may provide an override filename.
	 * When an error has ocurred or transfer is complete the optional callback fn is invoked. 
	 * This method uses res.sendfile() to transfer the file.
	 * @param	p_path
	 * @param	p_options
	 * @param	p_fn
	 */
	@:overload(function(p_path:String):Void{})
	@:overload(function(p_path:String,p_options:Dynamic):Void{})	
	function download(p_path:String, p_options:Dynamic, p_fn: Error -> Void):Void;
	
	
	/**
	 * Join the given links to populate the "Link" response header field.
	 * @param	p_links
	 */
	function links(p_links:Dynamic):Void;
		
	/**
	 * Render a view with a callback responding with the rendered string. When an error occurs next(err) is invoked internally. When a callback is provided both the possible error and rendered string are passed, and no automated response is performed.
	 */
	function render(view:String, ?locals:Dynamic, ?callback:Function):Void;

	/**
	 * Sets the response timeout.
	 */
	function setTimeout(milliseconds :Float):Void;

	/**
	 * Sets or appends the response header
	 */
	function setHeader(key :String, val :String):Void;

	/**
	 */
	function writeHead(status :Int):Void;

	function end(?data :Dynamic):Void;

}