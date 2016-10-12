package js.npm.request;

import js.node.stream.Readable;
import js.node.stream.Writable;

typedef HttpResponse = {
	var statusCode :Int;
}
typedef Body=String;

@:jsRequire("request")
extern class Request
{
	public static function post(urlOrParams :Dynamic, ?cb :Null<js.Error>->Null<HttpResponse>->Null<Body>->Void) :IWritable;
	public static function get(urlOrParams :Dynamic, ?cb :Null<js.Error>->Null<HttpResponse>->Null<Body>->Void) :IReadable;
}
