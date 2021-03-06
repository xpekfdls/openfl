package openfl.utils;

#if !openfl_global
@:jsRequire("openfl/utils/AssetManifest", "default")
#end
extern class AssetManifest /*extends LimeAssetManifest*/
{
	public function new();
	public function addBitmapData(path:String, id:String = null):Void;
	public function addBytes(path:String, id:String = null):Void;
	public function addFont(name:String, id:String = null):Void;
	public function addSound(paths:Array<String>, id:String = null):Void;
	public function addText(path:String, id:String = null):Void;
}
