package openfl.display;

#if (display || !flash)
import openfl.utils.ByteArray;

#if !openfl_global
@:jsRequire("openfl/display/ShaderData", "default")
#end
@:final extern class ShaderData implements Dynamic
{
	public function new(byteArray:ByteArray):Void;
}
#else
typedef ShaderData = flash.display.ShaderData;
#end
