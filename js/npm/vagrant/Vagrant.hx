package js.npm.vagrant;

import js.Error;

@:enum
abstract VagrantMachineStatus(String) {
  var NotCreated = "not created";
  var Running = "running";
  var PowerOff = "poweroff";
  var Aborted = "aborted";
  var Saved = "saved";
}

typedef StatusResult = {
	var status :VagrantMachineStatus;
	var provider :String;
}

extern class VagrantMachine extends js.node.events.EventEmitter<Dynamic>
{
	public function init(args :Array<String>, cb :Error->Dynamic->Void) :Void;
	public function up(cb :Error->Dynamic->Void) :Void;
	public function status(cb :Error->Dynamic<StatusResult>->Void) :Void;
	public function sshConfig(cb :Error->{port :Int,hostname:String,user:String,private_key:String}->Void) :Void;
	public function suspend(cb :Error->Dynamic->Void) :Void;
	public function resume(cb :Error->Dynamic->Void) :Void;
	public function halt(cb :Error->Dynamic->Void) :Void;
	public function destroy(cb :Error->Dynamic->Void) :Void;
}

@:jsRequire("node-vagrant")
extern class Vagrant extends js.node.events.EventEmitter<Dynamic>
{
	public static function version(cb :Error->String->Void) :Void;
	public static function create(args :{cwd:String, env: Dynamic}) :VagrantMachine;
	public static function globalStatus(cb :Error->Dynamic->Void) :Void;
}