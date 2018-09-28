package js.npm.gm;
import js.node.Buffer;
import js.node.fs.ReadStream;

/**
 * Auxiliary class for size data.
 */
extern class Size
{
	/**
	 * Image Width.
	 */
	var width  : Int;
	
	/**
	 * Image Height.
	 */
	var height : Int;
}

/**
 * GraphicsMagick class.
 * @author 
 */
@:native("(require('gm').subClass( { imageMagick: true } ))")
extern class GM
{

	/**
	 * Creates a new Image.
	 */
	@:overload(function(p_width:Int,p_height:Int):Void{})
	@:overload(function(p_width:Int,p_height:Int,p_color:Int):Void{})
	@:overload(function(p_buffer :Buffer):Void{})
	@:overload(function(p_stream : ReadStream):Void{})
	@:overload(function(p_buffer :Buffer,p_file:String):Void{})
	@:overload(function(p_stream : ReadStream,p_file:String):Void{})
	function new(p_path:String):Void;
	
	//Getters
	
	/**
	 * Returns the number of colors
	 * @param	p_callback
	 */
	function color(p_callback : Dynamic->Int->Void) : GM;
	
	/**
	 * Returns the image color depth
	 * @param	p_callback
	 */
	function depth(p_callback : Dynamic->Int->Void) : GM;
	
	/**
	 * Returns image filesize
	 * @param	p_callback
	 */
	function filesize(p_callback : Dynamic->Int->Void) : GM;
	
	/**
	 * Returns the image format (gif, jpeg, png, etc).
	 * @param	p_callback
	 */
	function format(p_callback : Dynamic->String->Void) : GM;
	
	 
	/**
	 * Returns all image data available
	 * @param	p_callback
	 */
	function identify(p_callback : Dynamic->Dynamic->Void) : GM;
	
	
	/**
	 * Returns the EXIF orientation of the image
	 * @param	p_callback
	 */
	function orientation(p_callback : Dynamic->String->Void) : GM;
	
	/**
	 * Returns the image resolution.
	 * @param	p_callback
	 */
	function res(p_callback : Dynamic->String->Void) : GM;
	
	/**
	 * Returns the size (WxH) of the image.
	 * @param	p_callback
	 */
	function size(p_callback : Dynamic->Size->Void) : GM;
	
	//Operations
	
	/**
	 * Join images into a single multi-image file.
	 * @return
	 */
	function adjoin():GM;
	
	/**
	 * Drawing transform matrix
	 * This option provides a transform matrix {sx,rx,ry,sy,tx,ty} for use by subsequent -draw or -transform options.
	 * @param	p_matrix
	 * @return
	 */
	function affine(p_matrix:Dynamic):GM;
	
	/**
	 * Remove pixel aliasing
	 * By default antialiasing algorithms are used when drawing objects (e.g. lines) or rendering vector formats (e.g. WMF and Postscript).
	 * Use +antialias to disable use of antialiasing algorithms. 
	 * Reasons to disable antialiasing include avoiding increasing colors in the image, or improving rendering speed.
	 * @param	p_flag
	 * @return
	 */
	function antialias(p_flag:Bool):GM;
	
	/**
	 * Append a set of images.
	 * @param	p_path
	 * @param	p_ltr
	 * @return
	 */
	@:overload(function(p_path:String):GM { } )
	function append(p_path:String, p_ltr:Bool):GM;
	
	/**
	 * Decrypt image with this password.
	 * Use this option to supply a password for decrypting an image or an image sequence, 
	 * if it is being read from a format such as PDF that supports encryption. 
	 * Encrypting images being written is not supported.
	 * @param	p_pwd
	 * @return
	 */
	function authenticate(p_pwd:String):GM;
	
	/**
	 * Auto-orients the image according to its EXIF data.
	 * GraphicsMagick doesn't actually have the -auto-orient option but we emulate this by first reading 
	 * the EXIF data and rotate/flip from there.
	 * @return
	 */
	function autoOrient():GM;
	
	/**
	 * Average a set of images.
	 * @return
	 */
	function average():GM;
	
	/**
	 * display the image centered on a backdrop.
	 * This backdrop covers the entire workstation screen and is useful for hiding other X window activity
	 * while viewing the image. The color of the backdrop is specified as the foreground color (X11 default is black).
	 * @return
	 */
	function backdrop():GM;
	
	/**
	 * Specifies the number of bits of color to preserve in the image. 
	 * @param	p_bits
	 * @return
	 */
	function bitdepth(p_bits:Int):GM;
	
	/**
	 * Pixels below `threshold` become black.
	 * @param	p_r
	 * @param	p_g
	 * @param	p_b
	 * @param	p_a
	 * @return
	 */
	@:overload(function(p_r : Int):GM{})
	@:overload(function(p_r : Int, p_g:Int):GM{})
	@:overload(function(p_r : Int, p_g:Int, p_b:Int):GM{})
	function blackThreshold(p_r : Int, p_g:Int, p_b:Int, p_a:Int):GM;
	
	/**
	 * Blue chromaticity primary point.
	 * @param	p_x
	 * @param	p_y
	 * @return
	 */
	function bluePrimary(p_x:Int, p_y:Int):GM;
	
	/**
	 * Accepts a radius and optional sigma (standard deviation).
	 * @param	p_radius
	 * @param	p_sigma
	 * @return
	 */
	@:overload(function(p_radius : Int):GM{})
	function blur(p_radius:Int, p_sigma:Float):GM;
	
	var border						: Dynamic;
	var borderColor                 : Dynamic;
	var box                         : Dynamic;
	var channel                     : Dynamic;
	var charcoal                    : Dynamic;
	var chop                        : Dynamic;
	var clip                        : Dynamic;
	var coalesce                    : Dynamic;
	var colors                      : Dynamic;
	var colorize                    : Dynamic;
	var colorMap                    : Dynamic;
	var colorspace                  : Dynamic;
	var comment                     : Dynamic;
	var compose                     : Dynamic;
	var compress                    : Dynamic;
	var contrast                    : Dynamic;
	var convolve                    : Dynamic;
	var createDirectories           : Dynamic;
	var crop                        : Dynamic;
	var cycle                       : Dynamic;
	var deconstruct                 : Dynamic;
	var delay                       : Dynamic;
	var define                      : Dynamic;
	var density                     : Dynamic;
	var despeckle                   : Dynamic;
	var dither                      : Dynamic;
	var displace                    : Dynamic;
	var display                     : Dynamic;
	var dispose                     : Dynamic;
	var dissolve                    : Dynamic;
	var edge                        : Dynamic;
	var emboss                      : Dynamic;
	var encoding                    : Dynamic;
	var enhance                     : Dynamic;
	var endian                      : Dynamic;
	var equalize                    : Dynamic;
	var extent                      : Dynamic;
	var file                        : Dynamic;
	var filter                      : Dynamic;
	var flatten                     : Dynamic;
	var flip                        : Dynamic;
	var flop                        : Dynamic;
	var foreground                  : Dynamic;
	var frame                       : Dynamic;
	var fuzz                        : Dynamic;
	var gamma                       : Dynamic;
	var gaussian                    : Dynamic;
	var geometry                    : Dynamic;
	var gravity                     : Dynamic;
	var greenPrimary                : Dynamic;
	var highlightColor              : Dynamic;
	var highlightStyle              : Dynamic;
	var iconGeometry                : Dynamic;
	var implode                     : Dynamic;
	var intent                      : Dynamic;
	var interlace                   : Dynamic;
	var label                       : Dynamic;
	var lat                         : Dynamic;
	var level                       : Dynamic;
	var list                        : Dynamic;
	var limit                       : Dynamic;
	var log                         : Dynamic;
	var loop                        : Dynamic;
	var lower                       : Dynamic;
	var magnify                     : Dynamic;
	var map                         : Dynamic;
	var matte                       : Dynamic;
	var matteColor                  : Dynamic;
	var mask                        : Dynamic;
	var maximumError                : Dynamic;
	var median                      : Dynamic;
	var minify                      : Dynamic;
	var mode                        : Dynamic;
	var modulate                    : Dynamic;
	var monitor                     : Dynamic;
	var monochrome                  : Dynamic;
	var morph                       : Dynamic;
	var mosaic                      : Dynamic;
	var motionBlur                  : Dynamic;
	var name                        : Dynamic;
	var negative                    : Dynamic;
	var noise                       : Dynamic;
	var noop                        : Dynamic;
	var normalize                   : Dynamic;
	var noProfile                   : Dynamic;
	var opaque                      : Dynamic;

	#if (haxe_ver < 4)
	var operator                    : Dynamic;
	#else
	// operator is now a keyword
	// https://github.com/HaxeFoundation/haxe/issues/7413
	@:native("operator")
	var Operator                    : Dynamic;
	#end

	var orderedDither               : Dynamic;
	var outputDirectory             : Dynamic;
	var paint                       : Dynamic;
	var page                        : Dynamic;
	var pause                       : Dynamic;
	var pen                         : Dynamic;
	var ping                        : Dynamic;
	var pointSize                   : Dynamic;
	var preview                     : Dynamic;
	var process                     : Dynamic;
	var profile                     : Dynamic;
	var progress                    : Dynamic;
	var quality                     : Dynamic;
	var raise                       : Dynamic;
	var rawSize                     : Dynamic;
	var randomThreshold             : Dynamic;
	var recolor                     : Dynamic;
	var redPrimary                  : Dynamic;
	var region                      : Dynamic;
	var remote                      : Dynamic;
	var render                      : Dynamic;
	var repage                      : Dynamic;
	var resample                    : Dynamic;
	var resize                      : Dynamic;
	var roll                        : Dynamic;
	var rotate                      : Dynamic;
	var sample                      : Dynamic;
	var samplingFactor              : Dynamic;
	var scale                       : Dynamic;
	var scene                       : Dynamic;
	var scenes                      : Dynamic;
	var screen                      : Dynamic;
	var segment                     : Dynamic;
	var sepia                       : Dynamic;
	var set                         : Dynamic;
	var setFormat                   : Dynamic;
	var shade                       : Dynamic;
	var shadow                      : Dynamic;
	var sharedMemory                : Dynamic;
	var sharpen                     : Dynamic;
	var shave                       : Dynamic;
	var shear                       : Dynamic;
	var silent                      : Dynamic;
	var solarize                    : Dynamic;
	var snaps                       : Dynamic;
	var stegano                     : Dynamic;
	var stereo                      : Dynamic;
	var strip 					    : Dynamic;
	var spread                      : Dynamic;
	var swirl                       : Dynamic;
	var textFont                    : Dynamic;
	var texture                     : Dynamic;
	var threshold                   : Dynamic;
	var thumb                       : Dynamic;
	var tile                        : Dynamic;
	var transform                   : Dynamic;
	var transparent                 : Dynamic;
	var treeDepth                   : Dynamic;
	var trim                        : Dynamic;
	var type                        : Dynamic;
	var update                      : Dynamic;
	var units                       : Dynamic;
	var unsharp                     : Dynamic;
	var usePixmap                   : Dynamic;
	var view                        : Dynamic;
	var virtualPixel                : Dynamic;
	var visual                      : Dynamic;
	var watermark                   : Dynamic;
	var wave                        : Dynamic;
	var whitePoint                  : Dynamic;
	var whiteThreshold              : Dynamic;
	var window                      : Dynamic;
	var windowGroup                 : Dynamic;
	
	//Drawing
	var draw			: Dynamic;
	var drawArc         : Dynamic;
	var drawBezier      : Dynamic;
	var drawCircle      : Dynamic;
	var drawEllipse     : Dynamic;
	var drawLine        : Dynamic;
	var drawPoint       : Dynamic;
	var drawPolygon     : Dynamic;
	var drawPolyline    : Dynamic;
	var drawRectangle   : Dynamic;
	var drawText        : Dynamic;
	var fill            : Dynamic;
	var font            : Dynamic;
	var fontSize        : Dynamic;
	var stroke          : Dynamic;
	var strokeWidth     : Dynamic;
	var setDraw         : Dynamic;
	
	
	//Compare	
	var compare : Dynamic;
	
}