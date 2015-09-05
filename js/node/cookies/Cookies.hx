package js.node.cookies;
import js.node.http.IncomingMessage;
import js.node.http.ServerResponse;

/**
 * Configuration object for the get/set methods of the Cookies class.
 */
extern class CookieOptions
{
	/**
	 *  a number representing the milliseconds from Date.now() for expiry
	 */
	var maxAge : Int;
	
	/**
	 *  a Date object indicating the cookie's expiration date (expires at the end of session by default).
	 */
	var expires : Date;
	
	/**
	 *  a string indicating the path of the cookie ( / by default).
	 */
	var path : String;
	
	/**
	 *  a string indicating the domain of the cookie (no default).
	 */
	var domain : String;
	
	/**
	 *  a boolean indicating whether the cookie is only to be sent over HTTPS (false by default for HTTP, true by default for HTTPS).
	 */
	var secure : Bool;
	
	/**
	 *  a boolean indicating whether the cookie is only to be sent over HTTPS (use this if you handle SSL not in your node process).
	 */
	var secureProxy : Bool;
	
	/**
	 *  a boolean indicating whether the cookie is only to be sent over HTTP(S), and not made available to client JavaScript (true by default).
	 */
	var httpOnly : Bool;
	
	/**
	 *  a boolean indicating whether the cookie is to be signed (false by default). If this is true, another cookie of the same name with the .sig suffix appended will also be sent, with a 27 - byte url - safe base64 SHA1 value representing the hash of cookie-name = cookie-value against the first Keygrip key. This signature key is used to detect tampering the next time a cookie is received.
	 */
	var signed : Bool;
	
	/**
	 * a boolean indicating whether to overwrite previously set cookies of the same name (false by default). If this is true, all cookies set during the same request with the same name (regardless of path or domain) are filtered out of the Set - Cookie header when setting this cookie.
	 */
	var overwrite : Bool;
}

/**
 * Cookies is a node.js module for getting and setting HTTP(S) cookies. Cookies can be signed to prevent tampering, using Keygrip. It can be used with the built-in node.js HTTP library, or as Connect/Express middleware.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('cookies'))")
extern class Cookies
{
	
	/**
	 * This adds cookie support as a Connect middleware layer for use in Express apps, allowing inbound cookies to be read using req.cookies.get and outbound cookies to be set using res.cookies.set.
	 * @param	p_arg
	 * @return
	 */
	static public function express(p_keys : Dynamic):Dynamic;

	/**
	 * This creates a cookie jar corresponding to the current request and response. 
	 * A Keygrip object or an array of keys can optionally be passed as the third argument keygrip to enable cryptographic signing based on SHA1 HMAC, using rotated credentials.
	 * Note that since this only saves parameters without any other processing, it is very lightweight.
	 * Cookies are only parsed on demand when they are accessed.
	 * @param	p_request
	 * @param	p_response
	 * @param	p_keys
	 */
	@:overload(function(p_request : IncomingMessage, p_response : ServerResponse):Void { } )	
	public function new(p_request : IncomingMessage, p_response : ServerResponse,p_keys : Array<Dynamic>):Void; 
	
	/**
	 * This extracts the cookie with the given name from the Cookie header in the request. If such a cookie exists, its value is returned. Otherwise, nothing is returned.
	 * { signed: true } can optionally be passed as the second parameter options. In this case, a signature cookie (a cookie of same name ending with the .sig suffix appended) is fetched.
	 * If no such cookie exists, nothing is returned.
	 * If the signature cookie does exist, the provided Keygrip object is used to check whether the hash of cookie-name=cookie-value matches that of any registered key:
	 *   - If the signature cookie hash matches the first key, the original cookie value is returned.
	 *   - If the signature cookie hash matches any other key, the original cookie value is returned AND an outbound header is set to update the signature cookie's value to the hash of the first key. This enables automatic freshening of signature cookies that have become stale due to key rotation.
	 *   - If the signature cookie hash does not match any key, nothing is returned, and an outbound header with an expired date is used to delete the cookie.
	 * @param	p_name
	 * @param	p_options
	 */
	@:overload(function(p_name:String):String{})
	function get(p_name:String, p_options:CookieOptions):String;
	
	/**
	 * This sets the given cookie in the response and returns the current context to allow chaining.
	 * If the value is omitted, an outbound header with an expired date is used to delete the cookie.
	 * @param	p_name
	 * @param	p_value
	 * @param	p_options
	 */
	@:overload(function(p_name:String):Void { } )	
	@:overload(function(p_name:String, p_value:String):Void { } )	
	function set(p_name:String, p_value : String, p_options : CookieOptions):Void;
	
	
}