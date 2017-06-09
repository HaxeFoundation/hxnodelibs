package js.npm.ws;
import haxe.ds.ObjectMap;
import js.node.events.EventEmitter;
import js.node.http.Server;
import js.node.http.IncomingMessage;
import js.node.net.Socket;

@:enum abstract WebSocketServerEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> 
{
	/**
	 * function (error) { }
	 * If the underlying server emits an error, it will be forwarded here.
	 */
	var Error : WebSocketServerEvent<Error->Void> = "error";
	
	/**
	 * function (headers) { }
	 * Emitted with the object of HTTP headers that are going to be written to the Stream as part of the handshake.
	 */
	var Headers : WebSocketServerEvent<Dynamic->Void> = "headers";
		
	/**
	 * function (socket) { }
	 * When a new WebSocket connection is established. socket is an object of type ws.WebSocket.
	 */	
	var Connection : WebSocketServerEvent<Socket->Void> = "connection";
}

/**
 * 
 */
typedef WebSocketServerOption = {
	/**
	 * 
	 */
	@:optional var host : String;
	
	/**
	 * 
	 */
	@:optional var port : Int;
	
	/**
	 * 
	 */
	@:optional var server : Server;
	
	/**
	 * 
	 */
	@:optional var verifyClient : Dynamic;
	
	/**
	 * 
	 */
	@:optional var path : String;
	
	/**
	 * 
	 */
	@:optional var noServer : Bool;
	
	/**
	 * 
	 */
	@:optional var disableHixie : Bool;
	
	/**
	 * 
	 */
	@:optional var clientTracking : Bool;
}

/**
 * ...
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:jsRequire("ws", "Server")
extern class WebSocketServer extends EventEmitter<WebSocketServer>
{

	public var clients : Array<WebSocket>;

	/**
	 * Construct a new server object.
	 * Either port or server must be provided, otherwise you might enable noServer if you want to pass the requests directly.
	 * Please note that the callback is only used when you supply the a port number in the options.
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function(p_options:WebSocketServerOption):Void{})
	public function new(p_options:WebSocketServerOption, p_callback : Dynamic);
	
	/**
	 * Close the server and terminate all clients
	 * @param	p_code
	 * @param	p_data
	 */
	@:overload(function():Void{})
	@:overload(function(p_code:Int):Void{})
	function close(p_code:Int, p_data : Dynamic):Void;
	
	/**
	 * Handles a HTTP Upgrade request. request is an instance of http.ServerRequest, socket is an instance of net.Socket.
	 * When the Upgrade was successfully, the callback will be called with a ws.WebSocket object as parameter.
	 * @param	p_request
	 * @param	p_socket
	 * @param	p_upgradeHead
	 * @param	p_callback
	 */
	function handleUpgrade(p_request : IncomingMessage, p_socket : Socket, p_upgradeHead : Dynamic, p_callback : WebSocket -> Void):Void;
}
