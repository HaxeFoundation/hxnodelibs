package js.npm.reduxlogger;

import redux.IMiddleware;

@:jsRequire('redux-logger')
extern class ReduxLogger
{
	public static function createLogger<A,S>(?opts :Dynamic) :IMiddleware<A,S>;
}

