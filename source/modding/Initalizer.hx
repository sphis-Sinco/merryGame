package modding;

#if !hl
import polymod.*;

class Initalizer
{

    public static function scan()
    {
        Polymod.scan({
            modRoot: "mods/"
        });
    }
    
}
#end