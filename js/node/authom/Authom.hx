package js.node.authom;

import js.node.events.EventEmitter;
import js.node.http.Server;
import js.node.https.Server;
import js.node.http.IncomingMessage;
import js.node.http.ServerResponse;

/**
 * Enumeration for the possible events of the Authom class.
 */
class AuthomEventType
{
	/**
	 * Listens for successful authentications across all services. The listener is called with the original request/response objects as well as a service-specific user object [AuthomData]
	 * authom.on("auth", function(req, res, data){})
	 */
	static public var Auth : String = "auth";
	
	/**
	 * Listens for failed authentications across all services. Like the auth event, the listener is called with the original request/response objects as well as an error object, allowing you to provide your own session scheme.
	 * authom.on("error", function(req, res, data){})
	 */
	static public var Error : String = "error";
}

/**
 * 
 */
extern class AuthomServerOption
{
	/**
	 * 
	 */
	var service : String;
	
	/**
	 * 
	 */
	var id : String;
	
	/**
	 * 
	 */
	var name : String;
	
	/**
	 * 
	 */
	var secret : String;
	
	/**
	 * 
	 */
	var scope : Dynamic;
	
	/**
	 * 
	 */
	var info : Bool;
	
	/**
	 * 
	 */
	var fields : Dynamic;
	
	/**
	 * 
	 */
	var redirect_uri : String;
	
	/**
	 * 
	 */
	var state : String;
	
	/**
	 * 
	 */
	var emails : Bool;
	
	/**
	 * 
	 */
	var format : String;
}

/**
 * 
 */
extern class AuthomData
{
	/**
	 *  the token resulting from authentication
	 */
	var token : String;
	
	/**
	 *  the refresh_token resulting from authentication, if implemented by auth service, otherwise undefined
	 */
	var refresh_token : String;
	
	/**
	 *  the ID of the user on the remote service
	 */
	var id : String;
	
	/**
	 *  the original data returned from the service
	 */
	var data : Dynamic;
	
	/**
	 *  the name of the service, given so that you can branch your code:
	 */
	var service : String;
}

/**
 * authom is an authentication library for node.js. It unifies authentication APIs for multiple services into a single EventEmitter, and works with both the built-in node.js HTTP module and as an Express/Connect app.
 * authom was designed to solve one problem and solve it well. It has an intuitive node.js-like API, no required dependencies, and doesn't force any particular persistence, session, or middleware approaches on you.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("require('authom')")
extern class Authom implements Dynamic<Dynamic>
//extends EventEmitter
{	
	/**
	 * Returns an instance of Authom
	 */
	static var instance(get, never):Authom;
	static inline function get_instance():Authom { return cast Node.require("authom"); }
	
	/**
	 * A regular expression that is run on the pathname of every request.
	 * authom will only run if this expression is matched. 
	 * By default, it is /^\/auth\/([^\/]+)\/?$/.
	 */
	var route : EReg;
		
	/**
	 * This is a convenience Express app, which should be mounted at a path containing a :service parameter.
	 */
	function app():Dynamic;
	
	/**
	 * Creates an EventEmitter for the given authentication service.
	 * The service is specified by the service key of the options object, with all other keys differing based on the service.
	 * @param	p_options
	 */
	@:overload(function(p_options:AuthomServerOption):Dynamic<Dynamic>{})
	function createServer(p_options : AuthomServerOption, p_callback : IncomingMessage -> ServerResponse -> Void) : Dynamic<Dynamic>;
	
	
	/**
	 * Listens to an existing HTTP(S) server for request events. 
	 * Like socket.io's .listen method, authom will intercept any request whose path starts with /auth.
	 * @param	p_server
	 */
	@:overload(function(p_server: js.node.https.Server):Void { } )	
	function listen(p_server : js.node.http.Server):Void;
	
	/**
	 * A standard node.js listener. This can be used for more control over the path at which authom is used. For example, the following two are equivalent:
	 * @param	p_request
	 * @param	p_response
	 */
	function listener(p_request : IncomingMessage, p_response : ServerResponse):Void;
	
	/**
	 * Authom-compliant services can be registered using this method. 
	 * This is useful for adding custom authentication services not suited to be part of the /lib core services.
	 * (For example a business-specific in-house authentication service.) 
	 * Custom services will override existing services of the same name.
	 * @param	p_name
	 * @param	p_service
	 */
	function registerService(p_name:String, p_service : Dynamic -> Void):Void;
	
	
}