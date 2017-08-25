package js.npm.express;
import js.html.audio.DynamicsCompressorNode;
import js.node.http.IncomingMessage;
import js.node.http.ServerResponse;

/**
 * Class that describes an Application class settings object.
 */
extern class ApplicationSettings
{
	/**
	 * Environment mode, defaults to process.env.NODE_ENV (NODE_ENV environment variable) or "development"
	 */
	var env : Dynamic;
	
	/**
	 * Enables reverse proxy support, disabled by default	
	 */
	//trust proxy
	
	/**
	 * Changes the default callback name of ?callback=
	 */
	//jsonp callback name
	
	/**
	 * JSON replacer callback, null by default
	 */
	//json replacer
	
	/**
	 * Enable case sensitivity, disabled by default, treating "/Foo" and "/foo" as the same
	 */
	//case sensitive routing
	
	/**
	 * Enable strict routing, by default "/foo" and "/foo/" are treated the same by the router
	 */
	//strict routing
	
	/**
	 * Enables view template compilation caching, enabled in production by default
	 */
	//view cache
	
	/**
	 * The default engine extension to use when omitted
	 */
	//view engine 
	
	/**
	 * The view directory path, defaulting to "process.cwd() + '/views'"
	 */
	var views : String;
	
	/**
	 * Enables the X-Powered-By: Express HTTP header, enabled by default
	 */
	//x-powered-by
}

/**
 * ...
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class Application
{

	/**
	 * Application local variables are provided to all templates rendered within the application. 
	 * This is useful for providing helper functions to templates, as well as app-level data.
	 */
	var locals : Dynamic;
	
	/**
	 * Alter how Express will behave.
	 */
	var settings : ApplicationSettings;
	
	/**
	 * Bind and listen for connections on the given host and port, this method is identical to node's http.Server#listen().
	 * The app returned by express() is in fact a JavaScript Function, designed to be passed to node's http servers as a callback to handle requests. 
	 * This allows you to provide both HTTP and HTTPS versions of your app with the same codebase easily, as the app does not inherit from these, it is simply a callback:
	 * @param	p_port
	 */
	function listen(p_port:Int):Void;
	
	/**
	 * Assigns setting name to value.
	 * @param	p_name
	 * @param	p_value
	 */
	function set(p_name:String, p_value:String):Void;
	
	/**
	 * Set setting name to true.
	 * @param	p_name
	 */
	function enable(p_name:String):Void;
	
	/**
	 * Set setting name to false.
	 * @param	p_name
	 */
	function disable(p_name:String):Void;
	
	/**
	 * Check if setting name is enabled.
	 * @param	p_name
	 */
	function enabled(p_name:String):Bool;
	
	/**
	 * Check if setting name is disabled.
	 * @param	p_name
	 */
	function disabled(p_name:String):Bool;

	/**
	 * Use the given middleware function, with optional mount path, defaulting to "/".
	 * The "mount" path is stripped and is not visible to the middleware function.
	 * The main effect of this feature is that mounted middleware may operate without code changes regardless of its "prefix" pathname.
	 * @param	p_path
	 * @param	p_function
	 */
	@:overload(function(p_function : ExpressRequest -> ExpressResponse -> Dynamic):Void{})
	@:overload(function(p_path:String):Void{})
	function use(p_path:String,p_function : ExpressRequest -> ExpressResponse -> Dynamic):Void;

	/**
	 * Register the given template engine callback as ext By default will require() the engine based on the file extension. 
	 * For example if you try to render a "foo.jade" file Express will invoke the following internally, and cache the require() on subsequent calls to increase performance.
	 * @param	p_ext
	 * @param	p_callback
	 */
	function engine(p_ext : String, p_callback : Dynamic):Void;
	
	/**
	 * Map logic to route parameters. 
	 * For example when :user is present in a route path you may map user loading logic to automatically provide req.user to the route,
	 * or perform validations on the parameter input.
	 * The following snippet illustrates how the callback is much like middleware, thus supporting async operations,
	 * however providing the additional value of the parameter, here named as id. 
	 * An attempt to load the user is then performed, assigning req.user, otherwise passing an error to next(err).
	 * Alternatively you may pass only a callback, in which case you have the opportunity to alter the app.param() API. 
	 * For example the express-params defines the following callback which allows you to restrict parameters to a given regular expression.
	 * @param	p_name
	 * @param	p_callback
	 */
	@:overload(function(p_callback:Dynamic):Void { } )
	function param(p_name:String, p_callback:Dynamic):Void;
	
	
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
	
	
	/**
	 * Get setting name value.
	 * @param	p_name
	 * @return
	 */
	@:overload(function(p_name:String):String {})
	
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
	 * This method functions just like the app.VERB() methods, however it matches all HTTP verbs.
	 * This method is extremely useful for mapping "global" logic for specific path prefixes or arbitrary matches. 
	 * For example if you placed the following route at the top of all other route definitions, it would require that all routes from 
	 * that point on would require authentication, and automatically load a user. Keep in mind that these callbacks do not have to act as end points,
	 * loadUser can perform a task, then next() to continue matching subsequent routes.
	 * @param	p_path
	 * @param	p_cb0
	 * @param	p_cb1
	 * @param	p_cb2
	 * @param	p_cb3
	 */
	@:overload(function(p_exp : EReg, p_cb0 : Dynamic, ?p_cb1 : Dynamic, ?p_cb2 : Dynamic, ?p_cb3 : Dynamic):Void {})	
	function all(p_path:String, p_cb0 : Dynamic, ?p_cb1 : Dynamic, ?p_cb2 : Dynamic, ?p_cb3 : Dynamic):Void;
	
	/**
	 * Returns an instance of a single route which can then be used to handle HTTP verbs with optional middleware. Using app.route() is a recommended approach to avoiding duplicate route naming and thus typo errors.
	 * @param	p_path
	 */
	function route(p_path:String):Void;
	
	/**
	 * Render a view with a callback responding with the rendered string. This is the app-level variant of res.render(), and otherwise behaves the same way.
	 * @param	p_view
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function(p_view:String, p_callback : Dynamic):Void { } )	
	function render(p_view:String, p_options:Dynamic, p_callback : Dynamic):Void;
}
