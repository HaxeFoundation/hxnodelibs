package js.npm.bull;

import js.Error;
import js.Promise;
import js.node.events.EventEmitter;
import js.node.events.EventEmitter.Event;
import js.npm.redis.RedisClient;

typedef BullJobError=Dynamic;
typedef Done0=Void->Void;
typedef Done1=Error->Void;
typedef Done2<Result>=Null<BullJobError>->Result->Void;

typedef JobOptionsBackoff = {
	var type :String;
	var delay :Int;
}

typedef JobOptionsRepeatOpts = {
	@:optional var cron :String;
	@:optional var tz :String;
	@:optional var endDate :Dynamic;
	@:optional var limit :Int;
	@:optional var every :Float;
}

typedef JobOptions = {
	@:optional var delay :Int;
	@:optional var attempts :Int;
	@:optional var backoff :JobOptionsBackoff;
	@:optional var lifo :Bool;
	@:optional var timeout :Int;
	@:optional var jobId :String;
	@:optional var stackTraceLimit :Int;
	@:optional var removeOnComplete :Bool;
	@:optional var removeOnFail :Bool;
	@:optional var repeat :JobOptionsRepeatOpts;
	@:optional var priority :Int;
}

typedef BullJobCounts = {
	var waiting :Int;
	var active :Int;
	var completed :Int;
	var failed :Int;
	var delayed :Int;
}

@:enum
abstract RedisConnectionType(String) from String to String {
	var client = 'client';
	var subscriber = 'subscriber';
}

typedef BullOptions = {
	@:optional var redis :{?port:Int, ?host:String, ?password :String, ?db:Int};
	@:optional var limiter :{max:Float, duration:Float};
	@:optional var prefix :String;
	@:optional var settings :{
		?lockDuration :Float,
		?stalledInterval :Float,
		?maxStalledCount :Float,
		?guardInterval :Float,
		?retryProcessDelay :Float
	};
	@:optional var createClient :RedisConnectionType->RedisClient;
}

typedef Progress=Float;
typedef JobType=String;

/**
	Enumeration of events emitted by the `Readable` class.
**/
@:enum abstract QueueEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	var Ready : QueueEvent<Void->Void> = "ready";
	var Error : QueueEvent<Error->Void> = "error";
	var Active : QueueEvent<Job<Dynamic>->Promise<Dynamic>->Void> = "active";
	var Stalled : QueueEvent<Job<Dynamic>->Void> = "stalled";
	var Progress : QueueEvent<Job<Dynamic>->Progress->Void> = "progress";
	var Completed : QueueEvent<Job<Dynamic>->Dynamic->Void> = "completed";
	var Failed : QueueEvent<Job<Dynamic>->Dynamic->Void> = "failed";
	var Paused : QueueEvent<Void->Void> = "paused";
	var Resumed : QueueEvent<Job<Dynamic>->Void> = "resumed";
	var Cleaned : QueueEvent<Array<Job<Dynamic>>->JobType> = "cleaned";
}

@:jsRequire("bull")
extern class Queue<JobData, Result> extends EventEmitter<Queue<JobData, Result>>
{
	@:selfCall
	@:overload(function(queueName :String, url :String, opts :BullOptions) :Void { })
	@:overload(function(queueName :String, url :String) :Void { })
	@:overload(function(queueName :String) :Void { })
	public function new(queueName :String, opts :BullOptions) :Void;

	@:overload(function(concurrency :Int, job :Job<JobData>) :Promise<Dynamic> { })
	@:overload(function(job :Job<JobData>) :Promise<Dynamic> { })
	@:overload(function(cb :Job<JobData>->Done0->Void) :Void { })
	@:overload(function(cb :Job<JobData>->Done1->Void) :Void { })
	@:overload(function(cb :Job<JobData>->Done2<Result>->Void) :Void { })
	@:overload(function(concurrency :Int, cb :Job<JobData>->Done0->Void) :Void { })
	@:overload(function(concurrency :Int, cb :Job<JobData>->Done1->Void) :Void { })
	public function process(concurrency :Int, cb :Job<JobData>->Done2<Result>->Void) :Void;

	@:overload(function(queueName :String, data :JobData) :Promise<Job<JobData>> { })
	@:overload(function(queueName :String, data :JobData, opts :JobOptions) :Promise<Job<JobData>> { })
	@:overload(function(data :JobData) :Promise<Job<JobData>> { })
	public function add(data :JobData, opts :JobOptions) :Promise<Job<JobData>>;
	public function pause(?isLocal :Bool) :Promise<Dynamic>;
	public function resume(?isLocal :Bool) :Promise<Dynamic>;
	public function count() :Promise<Int>;
	public function getJobCounts() :Promise<BullJobCounts>;
	public function getActive() :Promise<Array<Job<JobData>>>;
	public function getActiveCount() :Promise<Int>;
	public function getDelayedCount() :Promise<Int>;
	public function getFailedCount() :Promise<Int>;
	public function getCompletedCount() :Promise<Int>;
	public function getWaitingCount() :Promise<Int>;
	public function getPausedCount() :Promise<Int>;
	public function getWaiting() :Promise<Int>;
	public function empty() :Promise<String>;
	public function close() :Promise<Void>;
	public function getJob(jobId :String) :Promise<Null<Job<JobData>>>;
	public function clean(gracePeriod :Int, ?type :JobType, ?limit :Int) :Promise<Void>;
}

extern class Job<JobData>
{
	public var data :JobData;
	public function progress(val :Progress) :Void;
	public function remove() :Promise<Void>;
	public function retry() :Promise<Void>;
}

