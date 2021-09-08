import haxe.io.Path;
import sys.FileSystem;

class BuildExamples {
    static function run() {
        Sys.setCwd("examples");
        for (file in FileSystem.readDirectory(".")) {
            if (Path.extension(file) == "hx") {
                var main = Path.withoutExtension(file);
                trace("Building example: " + main);
                Sys.command("haxe", [
                    "-main", main,
                    "-cp", "..",
                    "-lib", "tink_await",
                    "-lib", "hxnodejs",
                    "-lib", "react",
                    "-js", '$main.js',
                    "-D", "js-es5",
                    "-D", "analyzer",
                    "-dce", "full",
                ]);
            }
        }
    }
}