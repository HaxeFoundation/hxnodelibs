package js.npm.prometheus;

import haxe.extern.Rest;

typedef PrometheusCollectionArgs = {
	?registry :PrometheusRegistry,
	?timeout :Int,
}

// https://www.npmjs.com/package/redis-dump
@:jsRequire("prom-client")
extern class PrometheusClient implements Dynamic
{
	static var register :PrometheusRegistry;
	static function collectDefaultMetrics(?args :PrometheusCollectionArgs) :Void;

	static function linearBuckets(start :Float, interval :Float, count :Int) :Array<Float>;
	static function exponentialBuckets(start :Float, factor :Float, count :Int) :Array<Float>;

	static var contentType :String;
}

@:jsRequire("prom-client", "Registry")
extern class PrometheusRegistry
{
	public function new() :Void;

	var contentType :String;
	function metrics() :Dynamic;
}

typedef BaseConfig = {
	var help       : String;
	@:optional var labelNames : Array<String>;
	var name       : String;
}

extern class PrometheusBase<T>
{
	function reset() :Void;
	function labels(values:Rest<String>) :T;
}

extern class PrometheusBaseWithTimer<T>
	extends PrometheusBase<T>
{
	function startTimer(?labels :Dynamic) :Void->Void;
}

@:jsRequire("prom-client", "Counter")
extern class PrometheusCounter extends PrometheusBase<PrometheusCounter>
{
	public function new(config :BaseConfig) :Void;

	@:overload(function(labels :Dynamic, ?amount :Float) : Void {})
	function inc(?amount :Float) :Void;
}

@:jsRequire("prom-client", "Gauge")
extern class PrometheusGauge extends PrometheusBaseWithTimer<PrometheusGauge>
{
	public function new(config :BaseConfig) :Void;

	@:overload(function(labels :Dynamic, ?amount :Float) : Void {})
	function inc(?amount :Float) :Void;

	@:overload(function(labels :Dynamic, ?amount :Float) : Void {})
	function dec(?amount :Float) :Void;

	@:overload(function(labels :Dynamic, amount :Float) : Void {})
	function set(amount :Float) :Void;

	function setToCurrentTime() :Void;
}

typedef SummaryConfig = { >BaseConfig,
	var percentiles :Array<Float>;
}

@:jsRequire("prom-client", "Summary")
extern class PrometheusSummary extends PrometheusBaseWithTimer<PrometheusSummary>
{
	function new(config :SummaryConfig) :Void;

	@:overload(function(labels :Dynamic, val :Float) : Void {})
	function observe(val :Float) :Void;
}

typedef HistogramConfig = { >BaseConfig,
	var buckets :Array<Float>;
}

@:jsRequire("prom-client", "Histogram")
extern class PrometheusHistogram extends PrometheusBaseWithTimer<PrometheusSummary>
{
	function new(config :HistogramConfig) :Void;

	@:overload(function(labels :Dynamic, val :Float) : Void {})
	function observe(val :Float) :Void;
}