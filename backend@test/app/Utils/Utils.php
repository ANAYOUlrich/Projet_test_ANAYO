<?php
namespace App\Utils;

use hasfile;
use App\Models\TarifDescrip;

class Utils{

    public static function save_file($fichier, $new_name, $folder){
        $exten = $fichier->getClientOriginalExtension();
        $listeName = $new_name.'.'.$exten;
        $destinationPath = public_path('/'.$folder);
        $ulpoadListeSuccess = $fichier->move($destinationPath, $listeName);
        $path = $folder.'/' . $listeName;
        return $path;
    }
}
?>