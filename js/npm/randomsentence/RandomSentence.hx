package js.npm.randomsentence;

@:jsRequire('random-sentence')
extern class RandomSentence
{
	@:selfCall function new() :Void;

	@:selfCall static function generate(?opts :{min:Int,max:Int}) :String;
}