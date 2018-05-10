package js.npm.reduxlogger;

typedef IMiddleware<A,S> = Dynamic;

@:jsRequire('redux-logger')
extern class ReduxLogger
{
	public static function createLogger<A,S>(?opts :Dynamic) :IMiddleware<A,S>;
}

