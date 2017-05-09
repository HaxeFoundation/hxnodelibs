package js.npm;

@:jsRequire('long')
extern class Long
{
	public static var MAX_UNSIGNED_VALUE :Long;
	public static var MAX_VALUE :Long;
	public static var MIN_VALUE :Long;
	public static var NEG_ONE :Long;
	public static var ONE :Long;
	public static var UONE :Long;
	public static var UZERO :Long;
	public static var ZERO :Long;

	public static function fromBits (low :Int, high :Int, ?unsigned :Bool=false) :Long;
	public static function fromInt (low :Int, ?unsigned :Bool=false) :Long;
	public static function fromNumber (low :Float, ?unsigned :Bool=false) :Long;
	public static function fromString (s :String, ?unsigned :Bool=false, ?radix :Int=10) :Long;
	public static function isLong (obj :Dynamic) :Bool;
	//TODO: Many more instance methods

	public function new(low :Int, high :Int, ?unsigned :Bool=false) : Void;

	public function toString() :String;
}