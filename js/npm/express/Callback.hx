/**
 * This extern is intended to be temporary, until this PR is accepted:
 * https://github.com/HaxeFoundation/hxnodelibs/pull/17
 * If the PR is not accepted, then either this will stay here or
 * the callbacks will have to be converted to the non-typedef'ed version
 */

package js.npm.express;

import js.Error;

typedef Callback0 = Null<Error> -> Void;

typedef Callback1<A> = Null<Error> -> Null<A> -> Void;

typedef Callback2<A,B> = Null<Error> -> Null<A> -> Null<B> -> Void;

typedef Callback<T> = Callback1<T>;