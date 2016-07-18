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
	@:overload(function(url :String, ?cb :Null<js.Error>->Null<HttpResponse>->Null<Body>->Void):IWritable {})
	public static function post(postData :{url :String, formData :Dynamic}, ?cb :Null<js.Error>->Null<HttpResponse>->Null<Body>->Void) :IWritable;
	public static function get(url :String, ?cb :Null<js.Error>->Null<HttpResponse>->Null<Body>->Void) :IReadable;
}