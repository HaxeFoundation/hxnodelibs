package js.npm.express;
import haxe.ds.StringMap;

/**
 * A router is an isolated instance of middleware and routes. Routers can be thought of as "mini" applications only capable of performing middleware and routing. Every express application has a builtin app router.
 * Routers behave like middleware themselves and can be ".use()'d" by the app or in other routers.
 * Create a new router by using "express.Router()"
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class Router
{
	
	/**
	 * Use the given middleware function, with optional mount path, defaulting to "/".
	 * Middleware is like a plumbing pipe, requests start at the first middleware you define and work their way "down" the middleware stack processing for each path they match.
	 * @param	p_path
	 * @param	p_function
	 */
	@:overload(function(p_function:Dynamic):Void{})
	function use(p_path:String, p_function:Dynamic):Void;
	
	
	/**
	 * Map logic to route parameters. For example when :user is present in a route path you may map user loading logic to automatically provide req.user to the route, or perform validations on the parameter input.
	 * The following snippet illustrates how the callback is much like middleware, thus supporting async operations, however providing the additional value of the parameter, here named as id. An attempt to load the user is then performed, assigning req.user, otherwise passing an error to next(err).
	 * It is important to realize that any route that triggered a named parameter function to run will only be run if next was not called with an error in the named parameter handler.
	 * @param	p_name
	 * @param	p_function
	 */
	@:overload(function(p_callback:Dynamic):Void{})
	function param(p_name:String, p_callback:Dynamic):Void;
	
	/**
	 * Returns an instance of a single route which can then be used to handle HTTP verbs with optional middleware. 
	 * Using router.route() is a recommended approach to avoiding duplicate route naming and thus typo errors.
	 * Building on the router.param() example from before, we see how router.route() allows us to easily specify the various HTTP verb handlers.
	 * @param	p_path
	 */
	function route(p_path:String):Void;
	
	
	/**	 
	* The app.VERB() methods provide the routing functionality in Express, where VERB is one of the HTTP verbs, such as app.post(). 
	* Multiple callbacks may be given, all are treated equally, and behave just like middleware, with the one exception that these callbacks may invoke next('route') 
	* to bypass the remaining route callback(s). This mechanism can be used to perform pre-conditions on a route then pass control to subsequent routes when there is 
	* no reason to proceed with the route matched.
	 * @param	p_path
	 * @param	p_cb0
	 * @param	p_cb1
	 * @param	p_cb2
	 * @param	p_cb3
	 */	
	@:overload(function(p_exp : EReg, p_cb0 : Dynamic, ?p_cb1 : Dynamic, ?p_cb2 : Dynamic, ?p_cb3 : Dynamic):Void {})
	function get(p_path:String, p_cb0 : Dynamic, ?p_cb1 : Dynamic, ?p_cb2 : Dynamic, ?p_cb3 : Dynamic):Void;
	
	/**	 
	* The app.VERB() methods provide the routing functionality in Express, where VERB is one of the HTTP verbs, such as app.post(). 
	* Multiple callbacks may be given, all are treated equally, and behave just like middleware, with the one exception that these callbacks may invoke next('route') 
	* to bypass the remaining route callback(s). This mechanism can be used to perform pre-conditions on a route then pass control to subsequent routes when there is 
	* no reason to proceed with the route matched.
	 * @param	p_path
	 * @param	p_cb0
	 * @param	p_cb1
	 * @param	p_cb2
	 * @param	p_cb3
	 */
	@:overload(function(p_exp : EReg, ?p_cb0 : Dynamic, ?p_cb1 : Dynamic, ?p_cb2 : Dynamic, ?p_cb3 : Dynamic):Void {})
	function post(p_path:String, ?p_cb0 : Dynamic, ?p_cb1 : Dynamic, ?p_cb2 : Dynamic, ?p_cb3 : Dynamic):Void;
	
}