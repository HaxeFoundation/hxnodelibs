package js.npm.pkgcloud;

import haxe.extern.EitherType;

import js.Node;
import js.Error;
import js.node.stream.Writable;
import js.node.stream.Readable;

@:enum
abstract ProviderType(String) {
  var amazon = 'amazon';
  var google = 'google';
  //More to come
}

//https://github.com/pkgcloud/pkgcloud/blob/master/docs/providers/amazon.md#using-compute
//https://github.com/pkgcloud/pkgcloud/blob/master/lib/pkgcloud/amazon/client.js
typedef ClientOptionsAmazon = {>ProviderCredentials,
	var keyId :String;
	var key :String;
	var region :String;
	@:optional var securityGroup :String;
	@:optional var securityGroupId :String;
	@:optional var serversUrl :String;
}

typedef ComputeServerCreateOptions = {}

typedef ComputeServerCreateOptionsAmazon = {>ComputeServerCreateOptions,
	@:optional var name :String;
	@:optional var image :Dynamic;
	@:optional var flavor :Dynamic;
}

@:enum
abstract PkgCloudComputeStatus(String) {
  var error = 'ERROR';
  var provisioning = 'PROVISIONING';
  var reboot = 'REBOOT';
  var running = 'RUNNING';
  var stopped = 'STOPPED';
  var terminated = 'TERMINATED';
  var unknown = 'UNKNOWN';
  var updating = 'UPDATING';
}

typedef PkgCloudServer = {
	var id :String;
	var name :String;
	var status :PkgCloudComputeStatus;
	var addresses :Dynamic;
	var imageId :String;
}

typedef PkgCloudServerAws = {>PkgCloudServer,
	var imageId :String;
	var launchTime :String; //Format example: Mon Jan 04 2016 10:05:07 GMT-0800 (PST)
	var flavorId :String;
	var original :Dynamic;
}

typedef Image = {
	var name :String;
}

typedef ComputeClient = {
	function getServers(cb :Null<Error>->Array<PkgCloudServer>->Void) :Void;
	function createServer(options :ComputeServerCreateOptions, cb :Null<Error>->PkgCloudServer->Void) :Void;
	function destroyServer(serverId :String, cb :Null<Error>->PkgCloudServer->Void) :Void;
	function getServer(serverId :String, cb :Null<Error>->PkgCloudServer->Void) :Void;
	function rebootServer(serverId :String, cb :Null<Error>->PkgCloudServer->Void) :Void;
	function getImages(cb :Null<Error>->Array<Image>->Void) :Void;
}

typedef Container = {
	var name :String;
	function create(options :Dynamic, cb :Null<Error>->Container->Void) :Void;
	function refresh(cb :Null<Error>->Container->Void) :Void;
	function destroy(cb :Null<Error>->Void) :Void;
	function upload(file :String, local :Dynamic, options :Dynamic, cb :Null<Error>->Void) :IWritable;
	function getFiles(cb :Null<Error>->Array<File>->Void) :Void;
	function removeFile(file :File, ?cb :Null<Error>->Void) :Void;
}

typedef File = {
	var name :String;
	var fullPath :String;
	var containerName :String;
	function remove(cb :Null<Error>->Void) :Void;
	function download(options :Dynamic, ?cb :Null<Error>->Void) :IReadable;
}

typedef StorageClient = {
	function getContainers(cb :Error->Array<Container>->Void) :Void;
	function createContainer(options :Dynamic, cb :Null<Error>->Container->Void) :Void;
	function destroyContainer(containerName :String, cb :Null<Error>->Void) :Void;
	function getContainer(containerName :String, cb :Null<Error>->Container->Void) :Void;

	function upload(options :Dynamic) :IWritable;
	function download(options :Dynamic, ?cb :Null<Error>->Void) :IReadable;
	@:overload(function(container :EitherType<Container,String>, options :Dynamic, cb :Null<Error>->Array<File>->Void):Void {})
	function getFiles(container :Container, cb :Null<Error>->Array<File>->Void) :Void;
	function getFile(container :Container, fileName :String, cb :Null<Error>->File->Void) :Void;
	function removeFile(container :Container, file :File, ?cb :Null<Error>->Void) :Void;
}

typedef Credentials = {
}

typedef ProviderCredentials = { >Credentials,
	@:optional
	var provider :ProviderType;
}

typedef ProviderCredentialsLocal = { >ProviderCredentials,
	var baseLocalPath :String;
}

typedef ProviderLocal<T>  = {
	function createClient(credentials :ProviderCredentialsLocal) :T;
}

typedef ClientCreator<T> = {
	function createClient(credentials :Credentials) :T;
}

typedef ProviderClientCreator<T> = {
	function createClient(credentials :ProviderCredentials) :T;
}

typedef Provider = {
	var compute :ClientCreator<ComputeClient>;
	var storage :ClientCreator<StorageClient>;
	//Add more here as needed.
}

typedef Google = {
	var storage :ClientCreator<StorageClient>;
}

typedef Providers = {> Iterable<String>,
	var amazon :Provider;
	var azure :Provider;
	var digitalocean :Provider;
	var google :Provider;
	var local :Provider;
}

@:jsRequire('pkgcloud')
extern class PkgCloud extends js.node.events.EventEmitter<Dynamic>
{
	static public var providers :Providers;
	static public var compute :ClientCreator<ComputeClient>;
	static public var storage :ClientCreator<StorageClient>;
}