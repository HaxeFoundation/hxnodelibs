package js.npm;
/**
 * https://github.com/mscdex/busboy
 */
import js.node.http.*;
import js.node.stream.Readable;
import js.node.stream.Writable;
import js.node.events.EventEmitter;
import js.Error;

typedef FieldName=String;
typedef FileName=String;
typedef Encoding=String;
typedef MimeType=String;

typedef Value=String;
typedef FieldNameTruncated=Bool;
typedef ValueTruncated=Bool;


/**
	Enumeration of events emitted by the `Busboy` objects
**/
@:enum abstract BusboyEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	var File : BusboyEvent<FieldName->Readable<Dynamic>->FileName->Encoding->MimeType->Void> = "file";
	var Field : BusboyEvent<FieldName->Value->FieldNameTruncated->ValueTruncated->Void> = "field";
	var Finish : BusboyEvent<Void->Void> = "finish";
	var PartsLimit : BusboyEvent<Void->Void> = "partsLimit";
	var FilesLimit : BusboyEvent<Void->Void> = "filesLimit";
	var FieldsLimit : BusboyEvent<Void->Void> = "fieldsLimit";
}

@:jsRequire('busboy')
extern class Busboy extends Writable<Busboy>
{
	public function new(opts :{headers:Dynamic}) :Void;
}
