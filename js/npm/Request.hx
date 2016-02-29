package js.npm;

import js.node.stream.Readable;

typedef HttpResponse = {
	var statusCode :Int;
}
typedef Body=String;

@:jsRequire("request")
extern class Request
{
	public static function post(postData :{url :String, formData :Dynamic}, cb :Null<js.Error>->Null<HttpResponse>->Null<Body>->Void) :IReadable;
	public static function get(url :String, cb :Null<js.Error>->Null<HttpResponse>->Null<Body>->Void) :IReadable;
}