package js.npm;

import haxe.Json;

typedef ConstructorArgs = {
	var contactPoints :Array<String>;
	@:optional var keyspace :String; //This is strictly not necessary, but we'll create it not present
	@:optional var protocolOptions :{port :Int};
	@:optional var authProvider :Dynamic;
}

typedef Err=Dynamic;

typedef Result = {
	var rows :Array<Dynamic>;//This is the row object
	var info :{queriedHost :String, triedHosts :Dynamic<String>, achievedConsistency :Int};
	var rowLength :Int;
	var pageState : Dynamic;
	var columns :Array<{name :String, type :Int, sybtypes :Dynamic}>;
}

typedef ResultsCallback=Err->Result->Void;

@:jsRequire("cassandra-driver", "Client")
extern class Client extends js.node.events.EventEmitter
{
	public function new(args :ConstructorArgs) : Void;

	@:overload(function(csql :String, parameters :Array<Dynamic>, cb :ResultsCallback):Void {})
	@:overload(function(csql :String, parameters :Array<Dynamic>, queryParameters :Dynamic, cb :ResultsCallback):Void {})
	public function execute(csql :String, cb :ResultsCallback) : Void;

	public function connect(cb :Null<Err>->Void) : Void;
	public function shutdown(cb :Null<Err>->Void) : Void;

	public var metadata :Dynamic;
	public var keyspace :String;
}

@:jsRequire("cassandra-driver", "types.Uuid")
extern class Uuid
{
	public static function random() :Uuid;
	public static function fromString(val :String) :Uuid;
	public function toString() :String;
}

@:jsRequire("cassandra-driver", "types.Long")
extern class CassandraLong
{
	public static function fromNumber(n :Float) :CassandraLong;
	public static function fromString(val :String) :CassandraLong;

	public function toString() :String;
	public function equals(other :CassandraLong) :Bool;
	public function add(other :CassandraLong) :CassandraLong;
}

@:jsRequire("cassandra-driver", "auth.PlainTextAuthProvider")
extern class PlainTextAuthProvider
{
	public function new(login :String, password :String) :Void;
}

@:jsRequire("cassandra-driver", "Connection")
extern class Connection extends js.node.events.EventEmitter
{
	public function new(endPoint :String, protocolVersion :Float, options :ConstructorArgs) :Void;
	public function open(cb :Null<Err>->Void) :Void;
}