package js.npm.express;

import haxe.extern.EitherType;

/*
    can be any of:
        A string representing a path.
        A path pattern.
        A regular expression pattern to match paths.
        An array of combinations of any of the above.
*/
typedef Path = EitherType<EitherType<String, EReg>, Array<Path>>;
