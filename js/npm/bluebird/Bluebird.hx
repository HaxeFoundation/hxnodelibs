package js.npm.bluebird;

import haxe.Constraints;
import haxe.extern.EitherType;

@:jsRequire("bluebird")
extern class Bluebird<T, T2>
{
	// Statics
	public static function method<A1, A2>(fn : Function) : Bluebird<A1, A2>;
	public static function resolve<A1, A2>(value : Dynamic) : Bluebird<A1, A2>;
	public static function reject<A1, A2>(value : Dynamic) : Bluebird<A1, A2>;

	// Promisification
	@:overload(function<A1 : Function>(nodeFunction : A1) : A1 {})
	public static function promisify<A1 : Function>(nodeFunction : A1, ?receiver : Dynamic) : A1;

	@:overload(function<A1>(target : A1) : A1 {})
	public static function promisifyAll<A1>(target : Dynamic, ?options : {}) : A1;

	@:overload(function<A1, A2>(items : Array<A1>) : Bluebird<Array<A1>, A2> {})
	public static function all<A1, A2>(items : Array<Bluebird<A1, A2>>) : Bluebird<Array<A1>, A2>;

	@:overload(function<A2>(object : Bluebird<{}, A2>) : Bluebird<{}, A2> {})
	public static function props<A2>(object : {}) : Bluebird<{}, A2>;

	// Constructor
	@:overload(function() : Void {})
	@:overload(function(resolver : (T -> Void) -> Void) : Void {})
	public function new(resolver : (T -> Void) -> (T2 -> Void) -> Void);

	// Continuation
	@:overload(function<T3>(fulfilledHandler : T -> T3) : Bluebird<T3, T2> {})
	public function then<T3, T4>(fulfilledHandler : T -> T3, rejectedHandler : T2 -> T4) : Bluebird<T3, T4>;

	@:overload(function<T3>(fulfilledHandler : Function) : Bluebird<T3, T2> {})
	public function spread<T3, T4>(fulfilledHandler : Function, rejectedHandler : T2 -> T4) : Bluebird<T3, T4>;

	// Error handling
	@:overload(function<T5>(error : T5 -> Void) : Bluebird<T, T2> {})
	public function caught<T5>(cls : Class<T5>, error : T5 -> Void) : Bluebird<T, T2>;
	public function error<T5 : js.lib.Error>(rejectedHandler : T5 -> Void) : Bluebird<T, T2>;
	public function lastly<T3>(fulfilledHandler : T -> T3) : Bluebird<T3, T2>;

	// Status
	public function isFulfilled() : Bool;
	public function isRejected() : Bool;
	public function isPending() : Bool;
	public function value() : T;
	public function reason() : T2;

	// Delay
	public function delay(ms : Int) : Bluebird<T, T2>;

	// Utils
	public function tap<T3>(fulfilledHandler : T -> T3) : Bluebird<T3, T2>;
	public function get<T3>(index : EitherType<String, Int>) : Bluebird<T3, T2>;
	public function thenReturn<T3>(value : T3) : Bluebird<T3, T2>;
	public function thenThrow<T3>(value : T3) : Bluebird<T3, T2>;
}