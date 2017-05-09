package js.npm.ws;
import js.Error;
import js.node.events.EventEmitter;
import js.node.http.IncomingMessage;

/**
 * 
 */
@:enum abstract WebSocketEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> 
{
	/**
	 * function (error) { }
	 * If the client emits an error, this event is emitted (errors from the underlying net.Socket are forwarded here).
	 */
	var Error : WebSocketEvent<Error->Void> = "error";
	
	/**
	 * function (code, message) { }
	 * Is emitted when the connection is closed. code is defined in the WebSocket specification.
	 * The close event is also emitted when then underlying net.Socket closes the connection (end or close).
	 */
	var Close : WebSocketEvent<Int->String->Void> = "close";
	
	
	/**
	 * function () { }
	 * Emitted when the connection is established.
	 */
	var Open : WebSocketEvent<Void->Void> = "open";
		
	/**
	 * function (data, flags) { }
	 * Is emitted when data is received. flags is an object with member binary.
	 */
	var Message : WebSocketEvent<Dynamic->Dynamic->Void> = "message";	
	
	/**
	 * function (data, flags) { }
	 * Is emitted when a ping is received. flags is an object with member binary.
	 */
	var Ping : WebSocketEvent<Dynamic->Dynamic->Void> = "ping";	
	
	/**
	 * function (data, flags) { }
	 * Is emitted when a pong is received. flags is an object with member binary.
	 */
	var Pong : WebSocketEvent<Dynamic->Dynamic->Void> = "pong";	
	
}

class WebSocketReadyState
{
	static var Connecting 	: String = "CONNECTING";
	static var Open 		: String = "OPEN";
	static var Closing 		: String = "CLOSING";
	static var Closed 		: String = "CLOSED";
}

extern class WebSocketOption
{
	var protocol : String;
	
	var agent : Dynamic;
	
	var headers : Dynamic;
	
	var protocolVersion : Dynamic;	
	
	var host : String;
	
	var origin : String;
	
	var pfx : Dynamic;
	
	var key : Dynamic;
	
	var passphrase : String;
	
	var cert : Dynamic;
	
	var ca : Array<Dynamic>;
	
	var ciphers : String;
	
	var rejectUnauthorized : Bool;
}

/**
 * Flag instance received on 'message' event.
 */
extern class WebSocketMessageFlag
{
	/**
	 * will be set if a binary data is received
	 */
	var binary : Bool;
	
	/**
	 * will be set if the data was masked
	 */
    var masked :Bool; 
}

/**
 * ws: a node.js websocket library
 * https://github.com/einaros/ws
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('ws').WebSocket)")
extern class WebSocket extends EventEmitter<WebSocket>
{
	static var CONNECTING 	: Dynamic;
	
	static var OPEN 		: Dynamic;
	
	static var CLOSING 		: Dynamic;
	
	static var CLOSED 		: Dynamic;
	
	/**
	 * Received bytes count.
	 */
	var bytesReceived : Int;
	
	/**
	 * Possible states are WebSocket.CONNECTING, WebSocket.OPEN, WebSocket.CLOSING, WebSocket.CLOSED.
	 */
	var readyState : String;

	/**
	 * The WebSocket protocol version used for this connection, 8, 13 or hixie-76 (the latter only for server clients).
	 */
	var protocolVersion : String;
	
	/**
	 * The URL of the WebSocket server (only for clients)
	 */
	var url : String;
	
	/**
	 * Describes the feature of the used protocol version. 
	 * E.g. supports.binary is a boolean that describes if the connection supports binary messages.
	 */
	var supports : Dynamic;

	/**
	 * upgradeReq is the original request object
	 */
	var upgradeReq : IncomingMessage;
	
	/**
	 * Creates a new WebSocket.
	 * Instantiating with an address creates a new WebSocket client object. 
	 * If address is an Array (request, socket, rest), it is instantiated as a Server client (e.g. called from the ws.Server).
	 * @param	p_url
	 */
	@:overload(function(p_address:String):Void{})
	function new(p_address:String,p_options : WebSocketOption);
	
	/**
	 * Sends data through the connection. options can be an object with members mask and binary. The optional callback is executed after the send completes.
	 * Setting mask, will cause the data to be masked according to the websocket protocol. The same option applies for text data.
	 * @param	p_data
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function (p_data : Dynamic):Void { } )
	@:overload(function (p_data : Dynamic, p_options : WebSocketMessageFlag):Void{})	
	function send(p_data : Dynamic, p_options : WebSocketMessageFlag,p_callback:Dynamic):Void;
	
	
	/**
	 * Gracefully closes the connection, after sending a description message
	 * @param	p_code
	 * @param	p_data
	 */
	@:overload(function():Void{})
	@:overload(function(p_code:Int):Void{})
	function close(p_code:Int, p_data : Dynamic):Void;
	
	/**
	 * Pause the client stream
	 */
	function pause():Void;
		
	/**
	 * Sends a ping. data is sent, options is an object with members mask and binary. dontFailWhenClosed indicates whether or not to throw if the connection isnt open.
	 * @param	p_data
	 * @param	p_options
	 * @param	p_dontFailWhenClosed
	 */
	@:overload(function():Void{})
	@:overload(function(p_data:Dynamic):Void{})
	@:overload(function(p_data:Dynamic, p_options:WebSocketMessageFlag):Void{})
	function ping(p_data:Dynamic, p_options:WebSocketMessageFlag, p_dontFailWhenClosed:Bool):Void;
	
	/**
	 * Sends a pong. data is sent, options is an object with members mask and binary. dontFailWhenClosed indicates whether or not to throw if the connection isnt open.
	 * @param	p_data
	 * @param	p_options
	 * @param	p_dontFailWhenClosed
	 */	
	@:overload(function():Void{})
	@:overload(function(p_data:Dynamic):Void{})
	@:overload(function(p_data:Dynamic, p_options:WebSocketMessageFlag):Void{})
	function pong(p_data:Dynamic, p_options:WebSocketMessageFlag, p_dontFailWhenClosed:Bool):Void;

	/**
	 * Resume the client stream
	 */
	function resume():Void;

	/**
	 * Streams data through calls to a user supplied function. options can be an object with members mask and binary. callback is executed on successive ticks of which send is function (data, final).
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function(p_callback:Dynamic):Void { } )
	function stream(p_options : WebSocketMessageFlag, p_callback:Dynamic):Void;

	/**
	 * Immediately shuts down the connection
	 */
	function terminate():Void;
	
	/**
	 * Emulates the W3C Browser based WebSocket interface using function members.
	 */
	var onopen : Void->Void;
	
	/**
	 * Emulates the W3C Browser based WebSocket interface using function members.
	 */
	var onerror : Error->Void;
	
	/**
	 * Emulates the W3C Browser based WebSocket interface using function members.
	 */
	var onclose : Int->String;
	
	/**
	 * Emulates the W3C Browser based WebSocket interface using function members.
	 */
	var onmessage : Dynamic->WebSocketMessageFlag;
	
	/**
	 * Emulates the W3C Browser based WebSocket interface using addEventListener.
	 * @param	p_event
	 * @param	p_listener
	 */
	function addEventListener(p_event : String, p_listener : Dynamic):Void;
	
}
