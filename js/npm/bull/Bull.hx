package js.npm.bull;

import js.Error;
import js.node.events.EventEmitter;
import js.node.events.EventEmitter.Event;
import js.npm.bluebird.Bluebird;

typedef BullJobError=Dynamic;
typedef Done0=Void->Void;
typedef Done1=Error->Void;
typedef Done2<Result>=Null<BullJobError>->Result->Void;

typedef JobOptionsBackoff = {
	var type :String;
	var delay :Int;
}
typedef JobOptions = {
	@:optional var delay :Int;
	@:optional var attempts :Int;
	@:optional var backoff :JobOptionsBackoff;
	@:optional var lifo :Bool;
	@:optional var timeout :Int;
	@:optional var jobId :String;
	@:optional var removeOnComplete :Bool;
}

typedef Progress=Float;
typedef JobType=String;

/**
	Enumeration of events emitted by the `Readable` class.
**/
@:enum abstract QueueEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	var Ready : QueueEvent<Void->Void> = "ready";
	var Error : QueueEvent<Error->Void> = "error";
	var Active : QueueEvent<Job<Dynamic>->Bluebird<Dynamic,Dynamic>->Void> = "active";
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
	@:overload(function(queueName :String, redisConnectionString :String, ?redisOpts :Dynamic) :Void { })
	public function new(queueName :String, redisPort :Int, redisAddress :String, ?redisOpts :Dynamic) :Void;

	@:overload(function(concurrency :Int, job :Job<JobData>) :Bluebird<Dynamic, Dynamic> { })
	@:overload(function(job :Job<JobData>) :Bluebird<Dynamic, Dynamic> { })
	@:overload(function(cb :Job<JobData>->Done0->Void) :Void { })
	@:overload(function(cb :Job<JobData>->Done1->Void) :Void { })
	@:overload(function(cb :Job<JobData>->Done2<Result>->Void) :Void { })
	@:overload(function(concurrency :Int, cb :Job<JobData>->Done0->Void) :Void { })
	@:overload(function(concurrency :Int, cb :Job<JobData>->Done1->Void) :Void { })
	public function process(concurrency :Int, cb :Job<JobData>->Done2<Result>->Void) :Void;

	public function add(data :JobData, opts :JobOptions) :Bluebird<Job<JobData>, Dynamic>;
	public function pause(?isLocal :Bool) :Bluebird<Dynamic, Dynamic>;
	public function resume(?isLocal :Bool) :Bluebird<Dynamic, Dynamic>;
	public function count() :Bluebird<Int, Dynamic>;
	public function empty() :Bluebird<String, Dynamic>;
	public function close() :Bluebird<Void, Dynamic>;
	public function getJob(jobId :String) :Bluebird<Null<Job<JobData>>, Dynamic>;
	public function clean(gracePeriod :Int, ?type :JobType, ?limit :Int) :Bluebird<Void, Dynamic>;
}

extern class Job<JobData>
{
	public var data :JobData;
	public function progress(val :Progress) :Void;
	public function remove() :Bluebird<Void, Dynamic>;
	public function retry() :Bluebird<Void, Dynamic>;
}

