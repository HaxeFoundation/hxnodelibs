package js.npm.rsmq;

/* https://github.com/smrchy/rsmq */

import js.npm.redis.RedisClient;

import js.Error;

typedef RsmqConstructorOptions = {
	@:optional var host :String;
	@:optional var port :Int;
	@:optional var ns :String;
	@:optional var client :RedisClient;
	@:optional var options :Dynamic;
}

typedef RsmqCreateQueueOptions = {
	var qname :String;
	@:optional var vt :Float;
	@:optional var delay :Float;
	@:optional var maxSize :Int;
}

typedef RsmqSendMessageOptions<T> = {
	var qname :String;
	var message :T;
	@:optional var delay :Float;
}

typedef RsmqRecieveMessageOptions<T> = {
	var qname :String;
}

typedef RsmqDeleteMessageOptions = {
	var qname :String;
	var id :RsmqMessageId;
}

typedef RsmqMessageId=String;

typedef RsmqResponse=Int;

typedef RsmqMessage<T> = {
	var id :RsmqMessageId;
	var message :T;
	var sent :Float;
	var fr :Float;
	var rc :Int;
}

@:jsRequire("rsmq")
extern class Rsmq
{
	public function new(?options :RsmqConstructorOptions) :Void;
	public function createQueue(options :RsmqCreateQueueOptions, cb :Null<Error>->RsmqResponse->Void) :Void;
	public function sendMessage<T>(options :RsmqSendMessageOptions<T>, cb :Null<Error>->RsmqMessageId->Void) :Void;
	public function receiveMessage<T, T2>(options :RsmqRecieveMessageOptions<T>, cb :Null<Error>->RsmqMessage<T2>->Void) :Void;
	public function deleteMessage(options :RsmqDeleteMessageOptions, cb :Null<Error>->RsmqResponse->Void) :Void;

	public function listQueues(cb :Null<Error>->Array<String>->Void) :Void;
	public function quit() :Void;
}