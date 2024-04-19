package;

import haxe.zip.Entry;
import haxe.zip.Writer;
import haxe.Exception;
#if !html5
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

class UpdateZipSystem
{
	public static function unzip(_path:String, _dest:String, ignoreRootFolder:String = "")
	{
		#if !html5
		var _in_file = sys.io.File.read(_path);
		var _entries = haxe.zip.Reader.readZip(_in_file);

		_in_file.close();

		for (_entry in _entries)
		{
			var fileName = _entry.fileName;
			if (fileName.charAt(0) != "/" && fileName.charAt(0) != "\\" && fileName.split("..").length <= 1)
			{
				var dirs = ~/[\/\\]/g.split(fileName);
				if ((ignoreRootFolder != "" && dirs.length > 1) || ignoreRootFolder == "")
				{
					if (ignoreRootFolder != "")
					{
						dirs.shift();
					}

					var path = "";
					var file = dirs.pop();
					for (d in dirs)
					{
						path += d;
						sys.FileSystem.createDirectory(_dest + "/" + path);
						path += "/";
					}

					if (file == "")
					{
						continue; // was just a directory
					}
					path += file;
					//trace("unzip " + path);

					var data = unzipData(_entry);
					var f = File.write(_dest + "/" + path, true);
					f.write(data);
					f.close();
				}
			}
		} // _entry

		Sys.println('');
		Sys.println('unzipped successfully to ${_dest}');
		#end
	} // unzip

	public static function unzipData(f:Entry)
	{
		#if !html5
		if (!f.compressed)
			return f.data;
		var c = new haxe.zip.Uncompress(-15);
		var s = haxe.io.Bytes.alloc(f.fileSize);
		var r = c.execute(f.data, 0, s, 0);
		c.close();
		if (!r.done || r.read != f.data.length || r.write != f.fileSize)
			throw "Invalid compressed data for " + f.fileName;
		f.compressed = false;
		f.dataSize = f.fileSize;
		f.data = s;
		return f.data;
		#end
	}
}