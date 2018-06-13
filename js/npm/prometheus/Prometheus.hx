package js.npm.prometheus;

// https://www.npmjs.com/package/redis-dump
@:jsRequire("prom-client")
extern class PrometheusClient implements Dynamic
{
	static var register :PrometheusRegistry;
	static function collectDefaultMetrics(?args :PrometheusCollectionArgs) :Void;
}

typedef PrometheusCollectionArgs = {
	?registry :PrometheusRegistry,
	?timeout :Int,
}

@:jsRequire("prom-client", "Counter")
extern class PrometheusCounter
{
	public function new(config :{name :String,help :String}) :Void;
	function inc(?amount :Int) :Void;
	function reset() :Void;
}

@:jsRequire("prom-client", "Gauge")
extern class PrometheusGauge
{
	public function new(config :{name :String,help :String}) :Void;
	function inc(?amount :Int) :Void;
	function dec(?amount :Int) :Void;
	function set(amount :Int) :Void;
	function reset() :Void;
	function setToCurrentTime() :Void;
	function startTimer() :Void;
}

@:jsRequire("prom-client", "Registry")
extern class PrometheusRegistry
{
	public function new() :Void;

	var contentType :String;
	function metrics() :Dynamic;
}
