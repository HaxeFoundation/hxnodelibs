package js.npm.send;
import js.node.fs.WriteStream;
import js.node.http.IncomingMessage;

/**
 * Describes the options allowed to the 'send' method.
 */
extern class SendOption
{
	/**
	 * Set how "dotfiles" are treated when encountered. A dotfile is a file or directory that begins with a dot ("."). Note this check is done on the path itself without checking if the path actually exists on the disk. If root is specified, only the dotfiles above the root are checked (i.e. the root itself can be within a dotfile when when set to "deny").
	 * 'allow' No special treatment for dotfiles.
	 * 'deny' Send a 403 for any request for a dotfile.
	 * 'ignore' Pretend like the dotfile does not exist and 404.
	 * The default value is similar to 'ignore', with the exception that this default will not ignore the files within a directory that begins with a dot, for backward-compatibility.
	 */
	var dotfiles : String;
	
	/**
	 * Enable or disable etag generation, defaults to true.
	 */
	var etag : Bool;

	/**
	 * If a given file doesn't exist, try appending one of the given extensions, in the given order. By default, this is disabled (set to false). An example value that will serve extension-less HTML files: ['html', 'htm']. This is skipped if the requested file already has an extension.
	 */
	var extensions : Dynamic;

	/**
	 * By default send supports "index.html" files, to disable this set false or to supply a new index pass a string or an array in preferred order.
	 */
	var index : String;

	/**
	 * Enable or disable Last-Modified header, defaults to true. Uses the file system's last modified value.
	 */
	var lastModified : Bool;

	/**
	 * Provide a max-age in milliseconds for http caching, defaults to 0. This can also be a string accepted by the ms module.
	 */
	var maxAge : Int;

	/**
	 * Serve files relative to path.
	 */
	var root : String;
}


/**
 * Class that describes a static file send stream using the Http Server's request.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
class Send
{
	
	static var m_stream : IncomingMessage-> String->SendOption->IncomingMessage;
	
	/**
	 * Process the Http request to serve static files.
	 * @param	p_request
	 * @param	p_path
	 * @param	p_options
	 * @return
	 */
	static public function send(p_request:IncomingMessage, p_path:String, p_options : SendOption) : IncomingMessage
	{
		if (m_stream == null) m_stream = cast Node.require("send");		
		var fn : Dynamic = m_stream;
		return (p_options != null) ? fn(p_request, p_path, p_options) : fn(p_request, p_path);
	}
	
}