package js.node.express;

/**
 * http://expressjs.com/4x/api.html#req.params
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class ExpressRequest
{

	/**
	 * This property is an object containing properties mapped to the named route "parameters". 
	 * For example if you have the route /user/:name, then the "name" property is available to you as req.params.name.
	 * This object defaults to {}.
	 */
	var params : Dynamic;
	
	/**
	 * This property is an object containing the parsed query-string, defaulting to {}.
	 */
	var query				:Dynamic;
	
	/**
	 * The currently matched Route containing several properties such as the route's original path string, the regexp generated, and so on.
	 */
	var route               : Dynamic;
	
	/**
	 * When the cookieParser() middleware is used this object defaults to {}, otherwise contains the cookies sent by the user-agent.
	 */
	var cookies             :Dynamic;
	
	/**
	 * When the cookieParser(secret) middleware is used this object defaults to {}, otherwise contains the signed cookies sent by the user-agent, unsigned and ready for use. Signed cookies reside in a different object to show developer intent, otherwise a malicious attack could be placed on `req.cookie` values which are easy to spoof. Note that signing a cookie does not mean it is "hidden" nor encrypted, this simply prevents tampering as the secret used to sign is private.
	 */
	var signedCookies       : Dynamic;
	
	/**
	 * Return the remote address, or when "trust proxy" is enabled - the upstream address.
	 */
	var ip                  : String;
	
	/**
	 * When "trust proxy" is `true`, parse the "X-Forwarded-For" ip address list and return an array, otherwise an empty array is returned. 
	 * For example if the value were "client, proxy1, proxy2" you would receive the array ["client", "proxy1", "proxy2"] where "proxy2" is the furthest down-stream.
	 */
	var ips                 : Array<String>;
	
	/**
	 * Returns the request URL pathname.
	 */
	var path                : String;
	
	/**
	 * Returns the hostname from the "Host" header field (void of portno).
	 */
	var host                : String;
	
	/**
	 * Check if the request is fresh - aka Last-Modified and/or the ETag still match, indicating that the resource is "fresh".
	 */
	var fresh               : Bool;
	
	/**
	 * Check if the request is stale - aka Last-Modified and/or the ETag do not match, indicating that the resource is "stale".
	 */
	var stale               : Bool;
	
	/**
	 * Check if the request was issued with the "X-Requested-With" header field set to "XMLHttpRequest" (jQuery etc).
	 */
	var xhr                 : Bool;
	
	/**
	 * Return the protocol string "http" or "https" when requested with TLS. When the "trust proxy" setting is enabled the "X-Forwarded-Proto" header field will be trusted. If you're running behind a reverse proxy that supplies https for you this may be enabled.
	 */
	var protocol            : String;
	
	/**
	 * Check if a TLS connection is established. This is a short-hand for: 'https' == req.protocol;
	 */
	var secure : Bool;
	
	/**
	 * Return subdomains as an array.
	 */
	var subdomains          : Array<String>;
	
	/**
	 * This property is much like req.url, however it retains the original request url, allowing you to rewrite req.url freely for internal routing purposes.
	 * For example the "mounting" feature of app.use() will rewrite req.url to strip the mount point.
	 */
	var originalUrl         : String;
	
	/**
	 * Return the value of param name when present.
	 * @param	p_name
	 * @return
	 */
	function param(p_name:String):String;
	
	/**
	 * Get the case-insensitive request header field. The Referrer and Referer fields are interchangeable.
	 * @param	p_name
	 * @return
	 */
	function get(p_name:String):String;
	
	/**
	 * Check if the given types are acceptable, returning the best match when true, otherwise undefined - in which case you should respond with 406 "Not Acceptable".
	 * The type value may be a single mime type string such as "application/json", the extension name such as "json", a comma-delimited list or an array. 
	 * When a list or array is given the best match, if any is returned.
	 * @param	p_method
	 */
	@:overload(function(p_methods:Array<String>):String{})
	function accepts(p_method:String):String;
		
	/**
	 * Check if the given charset are acceptable.
	 * Please refer to accepts for additional documentation or any issues and concerns.
	 * @param	p_charset
	 */
	function acceptsCharset(p_charset:String):Bool;
	
	/**
	 * Check if the given lang are acceptable.
	 * Please refer to accepts for additional documentation or any issues and concerns.
	 * @param	p_lang
	 */
	function acceptsLanguage(p_lang:String):Bool;
	
	/**
	 * Check if the incoming request contains the "Content-Type" header field, and it matches the give mime type.
	 * @param	p_type
	 * @return
	 */
	function is(p_type:String):Bool;
	
}