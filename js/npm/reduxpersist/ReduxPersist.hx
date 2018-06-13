package js.npm.reduxpersist;

@:jsRequire('redux-persist')
extern class ReduxPersist
{
	public static function persistStore() :Dynamic;
	public static function persistReducer(opts :Dynamic, reducer :Dynamic) :Dynamic;
}

@:jsRequire('redux-persist/integration/react')
extern class PersistGate extends react.ReactComponent { }


@:jsRequire('redux-persist/lib/storage')
extern class ReduxPersistStorage{ }

