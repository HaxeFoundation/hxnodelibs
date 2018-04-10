package js.npm.pem;

import js.Error;

typedef PemCreateCertificationOptions = {
	@:optional var serviceKey :String;
	@:optional var serviceKeyPassword :String;
	@:optional var serviceCertificate :String;
	@:optional var serial :String;
	@:optional var selfSigned :Bool;
	@:optional var days :Int;
	@:optional var extFile :String;
	@:optional var config :String;
}

typedef PemKeys ={
	var serviceKey :String;
	var certificate :String;
}

@:jsRequire("pem")
extern class Pem
{
  static function createCertificate(opts : PemCreateCertificationOptions, cb :Null<Error>->PemKeys->Void) :Void;
}
