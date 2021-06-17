import tink.CoreApi.Promise;
import tink.core.Promise;
import js.npm.mongodb.MongoCollection;
import js.npm.mongodb.MongoCursor;
import js.npm.mongodb.MongoDatabase;
import js.lib.Error;
import js.npm.mongodb.MongoClient;

@await class MongoExample
{
    static function main()
    {
        new MongoExample();
    }

    public function new()
    {
        init();
    }

    private function init():Void
    {
        MongoClient.connect("mongodb://127.0.0.1:27017", null, handleConnect);
    }

    @await private function handleConnect(error:Error, database:MongoDatabase):Void
    {
        if (error != null)
        {
            trace("Connection error: " + error);

            return;
        }

        trace("Connected!");

        var result:Dynamic;
        var adminDatabase:MongoDatabase = database.db("admin");
        var collection:MongoCollection = adminDatabase.collection("TestCollection");

        result = @await Promise.ofJsPromise(collection.insertOne({name: "Bidoras"}));

        trace("insertOne result: " + result);

        result = @await Promise.ofJsPromise(collection.findOne({name: "Bidoras"}));

        trace("findOne result: " + result);

        result = @await Promise.ofJsPromise(collection.insertMany([{name: "4mo"}, {name: "Tvar"}, {name: "Petuh"}]));

        trace("insertMany result: " + result);

        cast (collection.find({"$or": [{name: "4mo"}, {name: "Petuh"}]}), MongoCursor)
            .limit(4)
            .toArray((error:Error, result:Dynamic) ->
            {
                if (error != null)
                {
                    trace("find all with 2 limit error: " + error);
                } else
                {
                    trace("find all with 2 limit result: " + result);
                }

                adminDatabase.close();
            }
        );
    }
}
