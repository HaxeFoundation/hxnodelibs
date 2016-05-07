package js.npm;

import js.node.stream.Readable;
import js.node.stream.Writable;
import js.Error;

/**
 * https://www.npmjs.com/package/dockerode#readme
 * https://docs.docker.com/docker/reference/api/docker_remote_api_v1.19/
 */

import js.Node;

@:enum
abstract DockerMachineStatus(String) {
  var Created = "created";
  var Running = "running";
  var Restarting = "restarting";
  var Paused = "paused";
  var Exited = "exited";
}

typedef DockerContainerId=String;

typedef ConstructorOpts = {
	//These
	@:optional var protocol :String;
	@:optional var host :String;
	@:optional var port :Int;
	@:optional var ca :String;
	@:optional var cert :String;
	@:optional var key :String;
	//or this
	@:optional var socketPath :String;
}

typedef ImageId=String;

typedef ImageData = {
	var Created :Float;
	var Id :ImageId;
	var ParentId :String;
	var RepoTags :Array<String>;
	var RepoDigests :Array<String>;
	var Size :Int;
	var VirtualSize :Int;
	var Labels :Array<String>;
}

typedef PortInfo = {
	var PrivatePort :Int;
	var PublicPort :Int;
	var Type :String;
}

typedef ContainerData = {
	var Id :DockerContainerId;
	var Image :String;
	var Command :String;
	var Created :Float;
	var Ports :Array<PortInfo>;
	var SizeRw :Int;
	var SizeRootFs :Int;
	var Labels :Array<String>;
	var Status :DockerMachineStatus;
}

typedef ListContainerOptions = {
	@:optional var all :Bool;
	@:optional var limit :Int;
	@:optional var before :String;
	@:optional var size :Int;
	@:optional var since :Int;
	@:optional var filters :Dynamic;
}

typedef BuildImageOptions = {
	@:optional var dockerFile :String;
	@:optional var t :String;
	@:optional var remote :String;
	@:optional var q :Bool;
	@:optional var nocache :Bool;
	@:optional var pull :Bool;
	@:optional var rm :Bool;
	@:optional var forcerm :Bool;
	@:optional var memory :Int;
	@:optional var memswap :Int;
	@:optional var cpushares :Int;
	@:optional var cpusetcpus :Int;
}

typedef Mount = {
	var Source: String;
	var Destination: String;
	@:optional var Mode: String;
	@:optional var RW: Bool;
}

@:enum //https://docs.docker.com/engine/admin/logging/overview/
abstract DockerLoggingDriver(String) {
	var none = "none";
	var jsonfile = "json-file";
	var syslog = "syslog";
	var journald = "journald";
	var gelf = "gelf";
	var fluentd = "fluentd";
	var awslogs = "awslogs";
	var splunk = "splunk";
	var etwlogs = "etwlogs";
	var gcplogs = "gcplogs";
}

typedef CreateContainerHostConfigLogConfig = {
	var Type: DockerLoggingDriver;
	var Config: Dynamic;
}

typedef CreateContainerHostConfig = {
	@:optional var Binds :Array<String>;
	@:optional var Links :Array<String>;
	@:optional var LogConfig :CreateContainerHostConfigLogConfig;
}

typedef CreateContainerOptions = {
	var Image :String;
	@:optional var Cmd :Array<String>;
	@:optional var Env :Array<String>;
	@:optional var name :String;
	@:optional var WorkingDir :String;
	@:optional var Mounts :Array<Mount>;
	@:optional var Labels :Dynamic;
	@:optional var Entrypoint :String;
	@:optional var Tty :Bool;
	@:optional var AttachStdin :Bool;
	@:optional var AttachStdout :Bool;
	@:optional var AttachStderr :Bool;
	@:optional var Hostname :String;
	@:optional var Domainname :String;
	@:optional var User :String;
	@:optional var ExposedPorts :Dynamic;
	@:optional var HostConfig :CreateContainerHostConfig;
	@:optional var Volumes :Dynamic;
}

typedef StartContainerOptions = {
	@:optional var PortBindings:Dynamic;
}

typedef AttachContainerOptions = {
	@:optional var logs :Bool;
	@:optional var stream :Bool;
	@:optional var stdin :Bool;
	@:optional var stdout :Bool;
	@:optional var stderr :Bool;
}

typedef CreateImageOptions = {
	@:optional var fromImage :String;
	@:optional var fromSrc :String;
	@:optional var repo :String;
	@:optional var tag :String;
	@:optional var registry :String;
}

typedef PullImageOptions = {
	@:optional var fromImage :String;
	@:optional var repo :String;
	@:optional var tag :String;
	@:optional var registry :String;
}

typedef LogsOptions = {
	@:optional var follow :Bool;
	@:optional var stdout :Bool;
	@:optional var stderr :Bool;
	@:optional var since :Int;
	@:optional var timestamps :Bool;
	@:optional var tail :Int;
}

typedef DockerInfo = {
	var ID :String;
	var Name :String;
	var OperatingSystem :String;
	var MemTotal :Int;
	var MemoryLimit :Bool;
	var NCPU :Int;
	var Images :Int;
	var Containers :Int;
	var Labels :Array<String>;
}

typedef DockerContainerState = {
	var Error :String;
	var ExitCode :Int;
	var FinishedAt :String;
	var OOMKilled :Bool;
	var Paused :Bool;
	var Pid :Int;
	var Restarting :Bool;
	var Running :Bool;
	var StartedAt :String;
	var Status :DockerMachineStatus;
}

typedef ContainerInspectInfo = {
	var Args :Array<String>;
	var AppArmorProfile :String;
	var Config :CreateContainerOptions;
	var Created :String;
	var HostConfig :Dynamic;
	var HostnamePath :String;
	var HostsPath :String;
	var LogPath :String;
	var Id :String;
	var Image :String;
	var MountLabel :String;
	var Name :String;
	var NetworkSettings :Dynamic;
	var State :DockerContainerState;
	var Mounts :Array<Mount>;
}

typedef RemoveContainerOpts = {
	@:optional var force :Bool;
	@:optional var v :Bool;
}

@:enum
abstract DockerBuildStatus(String) {
  var Extracting = "Extracting";
  var PullComplete = "Pull complete";
}

typedef ResponseStreamObject = {
	@:optional var status :DockerBuildStatus;
	@:optional var progressDetail :{current:Int,total:Int};
	@:optional var progress :String;
	@:optional var stream :String;
	@:optional var error :String;
	@:optional var errorDetail :{code: Int, message: String};
}

typedef DockerModem = {
	@:optional var host :String;
	@:optional var socketPath :String;
	@:optional var followProgress :IReadable->(Null<Error>->Array<Dynamic>->Void)->(Dynamic->Void)->Void;
}

@:jsRequire("dockerode")
extern class Docker extends js.node.events.EventEmitter<Dynamic>
{
	public var modem :DockerModem;

	public function new(opts :ConstructorOpts):Void;

	@:overload(function(options :Dynamic, cb :Error->Array<ImageData>->Void):Void {})
	public function listImages(cb :Error->Array<ImageData>->Void) :Void;

	@:overload(function(options :ListContainerOptions, cb :Error->Array<ContainerData>->Void):Void {})
	public function listContainers(cb :Error->Array<ContainerData>->Void) :Void;

	public function getContainer(id :String) :DockerContainer;
	public function createContainer(opts :CreateContainerOptions, cb :Null<Error>->Null<DockerContainer>->Void) :Void;

	@:overload(function(stream :js.node.stream.IReadable, opts:BuildImageOptions, cb :Error->Dynamic->Void):Void {})
	public function buildImage(file :String, opts:BuildImageOptions, cb:Error->IReadable->Void) :Void;

	public function info(cb:Error->DockerInfo->Void) :Void;

	public function ping(cb :Null<Error>->Void) :Void;

	public function getImage(name :String) :DockerImage;
	public function createImage(?auth :Dynamic, opts :CreateImageOptions, cb:Error->IReadable->Void) :Void;

	@:overload(function(image :String, cmd :String, ?streams :Array<IWritable>, ?createOptions :Dynamic, ?startOptions:Dynamic, cb :Null<Error>->Null<Dynamic>->Null<DockerContainer>->Void):Void {})
	@:overload(function(image :String, cmd :String, stream :IWritable, ?createOptions :Dynamic, ?startOptions:Dynamic, cb :Null<Error>->Null<Dynamic>->Null<DockerContainer>->Void):Void {})
	@:overload(function(image :String, cmd :Array<String>, stream :IWritable, ?createOptions :Dynamic, ?startOptions:Dynamic, cb :Null<Error>->Null<Dynamic>->Null<DockerContainer>->Void):Void {})
	public function run(image :String, cmd :Array<String>, ?streams :Array<IWritable>, ?createOptions :Dynamic, ?startOptions:Dynamic, cb :Null<Error>->Null<Dynamic>->Null<DockerContainer>->Void) :Void;

	@:overload(function(image :String, cb: Null<Error>->Null<IReadable>->Void):Void {})
	public function pull(image :String, opts :PullImageOptions, cb: Null<Error>->Null<IReadable>->Void) :Void;
}

typedef DockerImageTagOptions = {
	var repo :String;
	var tag :String;
	@:optional var force :Bool;
}

extern class DockerImage extends js.node.events.EventEmitter<Dynamic>
{
	public var name :String;
	public function inspect(cb :Error->Dynamic->Void) :Void;
	public function history(cb :Error->Dynamic->Void) :Void;
	public function tag(options :DockerImageTagOptions, cb :Error->Dynamic->Void) :Void;
	public function remove(options :Dynamic, cb :Error->Dynamic->Void) :Void;
	public function push(options :{?tag :String}, cb :Error->Dynamic->Void, ?auth :Dynamic) :Void;
}

extern class DockerContainer extends js.node.events.EventEmitter<Dynamic>
{
	public var id :DockerContainerId;
	@:overload(function(opts :StartContainerOptions, cb :Null<Error>->Null<Dynamic>->Void):Void {})
	public function start(cb :Null<Error>->Null<Dynamic>->Void) :Void;

	@:overload(function(opts :{t:Int}, cb :Null<Error>->Null<Dynamic>->Void):Void {})
	public function stop(cb :Null<Error>->Null<Dynamic>->Void) :Void;

	@:overload(function(opts :{t:Int}, cb :Null<Error>->Null<Dynamic>->Void):Void {})
	public function restart(cb :Null<Error>->Null<Dynamic>->Void) :Void;

	@:overload(function(opts :{signal:Dynamic}, cb :Null<Error>->Null<Dynamic>->Void):Void {})
	public function kill(cb :Null<Error>->Null<Dynamic>->Void) :Void;

	public function attach(opts :AttachContainerOptions, cb :Null<Error>->Null<IReadable>->Void) :Void;

	@:overload(function(opts :RemoveContainerOpts, cb :Null<Error>->Null<Dynamic>->Void):Void {})
	public function remove(cb :Null<Error>->Null<Dynamic>->Void) :Void;

	@:overload(function(cb: Null<Error>->Null<IReadable>->Void):Void {})
	public function logs(?opts :LogsOptions, cb: Null<Error>->Null<IReadable>->Void) :Void;

	public function inspect(cb: Null<Error>->Null<ContainerInspectInfo>->Void) :Void;

	public function getArchive(opts:{path:String}, cb: Null<Error>->Null<IReadable>->Void) :Void;
	public function putArchive(stream :IReadable, opts:{path:String, ?noOverwriteDirNonDir:String}, cb: Null<Error>->Null<Dynamic>->Void) :Void;

	public function wait(cb: Null<Error>->{StatusCode:Int}->Void) :Void;
	public function pause(cb: Null<Error>->Void) :Void;
	public function unpause(cb: Null<Error>->Void) :Void;
}