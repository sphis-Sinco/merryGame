package backend;

class Assets
{

    public static function getPath(path:String) return '$path';
    public static function getAssetPath(path:String) return getPath('assets/$path');

    public static function getDataPath(path:String) return getAssetPath('data/$path');

    public static function txt(file:String) return getDataPath('$file.txt');
    public static function json(file:String) return getDataPath('$file.json');

    public static function image(file:String) return getAssetPath('images/$file.png');


    public static function pathExists(path:String) {

        #if desktop
        return sys.FileSystem.exists(path);
        #end

        return false;
    }
    
    public static function makePath(path:String) {

        #if desktop
        sys.io.File.saveContent(path, '');
        #end
    }
    
    public static function saveToFile(path:String, content:String) {

        #if desktop
        sys.io.File.saveContent(path, content);
        #end
    }
    
    public static function readDirectory(directory:String) {

        #if desktop
        return sys.FileSystem.readDirectory(directory);
        #end

        return [];
    }
    
}