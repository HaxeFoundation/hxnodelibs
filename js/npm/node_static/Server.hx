package js.npm.node_static;
import js.node.http.IncomingMessage;
import js.node.http.ServerResponse;

/**
 * Creation options for node-static server
 */
extern class NodeStaticServerOption
{
	var cache      : Int;
	var headers    : Dynamic;
	var indexFile  : String;
	var serverInfo : String;
	var gzip 	   : Bool;
}

/**
 * Externs for the 'node-static' library.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('node-static').Server)")
extern class Server
{

	/**
	 * CTOR
	 * @param	p_path
	 * @param	p_options
	 */
	function new(p_path:String, ?p_options:NodeStaticServerOption);
	
	/**
	 * Serves the files.
	 * @param	p_request
	 * @param	p_response
	 * @param	p_callback
	 */
	@:overload(function (p_request:IncomingMessage, p_response:ServerResponse):Void{})	
	function serve(p_request:IncomingMessage, p_response:ServerResponse, p_callback:Error->Dynamic->Void):Void;
	
	/**
	 * Serves a directory.
	 * @param	p_pathname
	 * @param	p_request
	 * @param	p_response
	 * @param	p_finish
	 */
	function serveDir(p_pathname : String, p_request : IncomingMessage, p_response:ServerResponse, p_finish : Int->Dynamic->Void):Void;
	
	/**
	 * Serves a file.
	 * @param	p_pathname
	 * @param	p_status
	 * @param	p_headers
	 * @param	p_request
	 * @param	p_response
	 */
	function serveFile(p_pathname : String, p_status:Int, p_headers : Dynamic, p_request : IncomingMessage, p_response:ServerResponse):Void;
}