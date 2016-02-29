package js.npm;

import js.node.Http;

typedef ProxyServerOptions = {
	@:optional var target :String;
	@:optional var ssl :{key :String, cert :String};
	@:optional var secure :Bool;
	@:optional var ws :Bool;
	@:optional var forward :String;
	@:optional var agent :Dynamic;
	@:optional var xfwd :Bool;
	@:optional var toProxy :String;
	@:optional var hostRewrite :Bool;
	@:optional var autoRewrite :Bool;
	@:optional var changeOrigin :Bool;
	@:optional var localAddress :String;
	@:optional var ignorePath :Bool;
	@:optional var prependPath :Bool;
}

@:jsRequire('http-proxy')
extern class HttpProxy extends js.node.events.EventEmitter
{
	public static function createProxyServer(?options :ProxyServerOptions) :Proxy;
}

extern class Proxy extends js.node.events.EventEmitter
{
	public function close(?cb :Void->Void) :Void;
	public function listen(port :Int) :Void;
	public function web(req :HttpServerReq, res:HttpClientResp, ?options :Dynamic) :Void;
}
