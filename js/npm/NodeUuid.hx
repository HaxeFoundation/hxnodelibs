package js.npm;

@:jsRequire('uuid')
extern class NodeUuid
{
	public static function v1() :String;
	public static function v4() :String;
}
