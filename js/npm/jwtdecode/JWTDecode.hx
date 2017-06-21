package js.npm.jwtdecode;

@:jsRequire('jwt-decode')
extern class JWTDecode
{
	@:selfCall
	public static function decode<T>(jwtToken :String) :T;
}