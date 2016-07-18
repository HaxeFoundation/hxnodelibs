package js.npm.formidable;
/**
 * https://github.com/felixge/node-formidable
 */
import js.node.http.*;
import js.node.events.EventEmitter;
import js.Error;

typedef Fields=Array<String>;

@:jsRequire('formidable')
extern class Formidable {}

/**
	Enumeration of events emitted by the `IncomingForm` objects
**/
@:enum abstract IncomingFormEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	var Progress : IncomingFormEvent<Int->Int->Void> = "progress";
	var Field : IncomingFormEvent<String->String->Void> = "field";
	var FileBegin : IncomingFormEvent<String->String->Void> = "fileBegin";
	var File : IncomingFormEvent<String->FormidableFile->Void> = "file";
	var Error : IncomingFormEvent<Error->Void> = "error";
	var Aborted : IncomingFormEvent<Void->Void> = "aborted";
	var End : IncomingFormEvent<Void->Void> = "end";
}

@:jsRequire('formidable', 'IncomingForm')
extern class IncomingForm extends EventEmitter<IncomingForm>
{
	public var encoding :String;
	public var uploadDir :String;
	public var keepExtensions :Bool;
	public var type :String;
	public var maxFieldsSize :Float;
	public var maxFields :Int;
	public var hash :haxe.extern.EitherType<Bool,String>;
	public var multiples :Bool;
	public var bytesReceived :Int;
	public var bytesExpected :Int;
	public var onPart :js.node.events.EventEmitter<Dynamic>->Void;

	public function parse(req :IncomingMessage, ?cb :Error->Fields->Array<FormidableFile>->Void) :Void;
}

extern class FormidableFile
{
	public var size :Int;
	public var path :String;
	public var name :String;
	public var type :String;
	public var lastModifiedDate :Dynamic;
	public var hash :String;
	public function toJson() :Dynamic;
}
