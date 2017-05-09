package js.npm.moment;

import haxe.extern.EitherType;

@:jsRequire("moment-timezone")
extern class MomentTimezone
{
	@:selfCall public function new(?date :EitherType<String,Float>, ?format :String);

	public function tz(timezone :String) :MomentTimezone;
	public function format(format :String) :MomentTimezone;
	public function toString() :String;
}