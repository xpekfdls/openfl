package openfl.display;

#if !flash
import openfl.display3D.Context3DMipFilter;
import openfl.display3D.Context3DTextureFilter;
import openfl.display3D.Context3DWrapMode;

/**
	// TODO: Document GLSL Shaders
	A ShaderInput instance represents a single input image for a shader
	kernel. A kernel can be defined to accept zero, one, or more source images
	that are used in the kernel execution. A ShaderInput instance provides a
	mechanism for specifying the input image that is used when the shader
	executes. To specify a value for the input, create a BitmapData,
	ByteArray, or Vector.<Number> instance containing the image data and
	assign it to the `input` property.
	The ShaderInput instance representing a Shader instance's input image is
	accessed as a property of the Shader instance's `data` property. The
	ShaderInput property has the same name as the input's name in the shader
	code. For example, if a shader defines an input named `src`, the
	ShaderInput instance representing the `src` input is available as the
	`src` property, as this example shows:

	```haxe
	myShader.data.src.input = new BitmapData(50, 50, true, 0xFF990000);
	```

	For some uses of a Shader instance, you do not need to specify an input
	image, because it is automatically specified by the operation. You only
	need to specify an input when a Shader is used for the following:

	* Shader fill
	* ShaderFilter, only for the second or additional inputs if the shader is
	defined to use more than one input. (The object to which the filter is
	applied is automatically used as the first input.)
	* Shader blend mode, only for the third or additional inputs if the shader
	is defined to use more than two inputs. (The objects being blended are
	automatically used as the first and second inputs.)
	* ShaderJob background execution

	If the shader is being executed using a ShaderJob instance to process a
	ByteArray containing a linear array of data, set the ShaderInput
	instance's `height` to 1 and `width` to the number of 32-bit floating
	point values in the ByteArray. In that case, the input in the shader must
	be defined with the `image1` data type.

	Generally, developer code does not create a ShaderInput instance directly.
	A ShaderInput instance is created for each of a shader's inputs when the
	Shader instance is created.
**/
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
#if (!js && !display)
// @:generic
#end
@:final class ShaderInput<T> /*implements Dynamic*/
{
	/**
		The number of channels that a shader input expects. This property must
		be accounted for when the input data is a ByteArray or Vector.<Number>
		instance.
	**/
	public var channels(default, null):Int;

	/**
		The texture filter to use when binding this shader input.

		This property is not available when targeting Flash.
	**/
	public var filter:Context3DTextureFilter;

	/**
		The height of the shader input. This property is only used when the
		input data is a ByteArray or Vector.<Number> instance. When the input
		is a BitmapData instance the height is automatically determined.
	**/
	public var height:Int;

	/**
		The zero-based index of the input in the shader, indicating the order
		of the input definitions in the shader.
	**/
	@SuppressWarnings("checkstyle:Dynamic") public var index(default, null):Dynamic;

	/**
		The input data that is used when the shader executes. This property
		can be a BitmapData instance, a ByteArray instance, or a
		Vector.<Number> instance.
		If a ByteArray value is assigned to the `input` property, the
		following conditions must be met:

		* The `height` and `width` properties must be set.
		* The byte array's contents must only consist of 32-bit floating-point
		values. These values can be written using the `ByteArray.writeFloat()`
		method.
		* The total length in bytes of the ByteArray must be exactly `width`
		times `height` times `channels` times 4.
		* The byte array's `endian` property must be `Endian.LITTLE_ENDIAN`.

		If a Vector.<Number> instance is assigned to the `input` property, the
		length of the Vector must be equal to `width` times `height` times
		`channels`.
	**/
	public var input:T;

	/**
		The mip filter to use when binding this shader input.

		This property is not available when targeting Flash.
	**/
	public var mipFilter:Context3DMipFilter;

	@:noCompletion @:dox(hide) @SuppressWarnings("checkstyle:FieldDocComment") public var name:String;

	/**
		The width of the shader input. This property is only used when the
		input data is a ByteArray or Vector.<Number> instance. When the input
		is a BitmapData instance the width is automatically determined.
	**/
	public var width:Int;

	/**
		The wrap mode to use when binding this shader input.

		This property is not available when targeting Flash.
	**/
	public var wrap:Context3DWrapMode;

	@:noCompletion private var __backend:ShaderInputBackend<T>;

	/**
		Creates a ShaderInput instance. Developer code does not call the
		ShaderInput constructor directly. A ShaderInput instance is created
		for each of a shader's inputs when the Shader instance is created.
	**/
	public function new()
	{
		channels = 0;
		filter = NEAREST;
		height = 0;
		index = 0;
		mipFilter = MIPNONE;
		width = 0;
		wrap = CLAMP;

		__backend = new ShaderInputBackend<T>(this);
	}
}

#if openfl_gl
private typedef ShaderInputBackend<T> = openfl._internal.backend.opengl.OpenGLShaderInputBackend<T>;
#else
private typedef ShaderInputBackend<T> = openfl._internal.backend.dummy.DummyShaderInputBackend<T>;
#end
#else
typedef ShaderInput<T> = flash.display.ShaderInput<T>;
#end
