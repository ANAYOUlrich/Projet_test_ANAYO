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

    public static function getRandom($nbre=6){
        // $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@#$';
        $characters = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
                $word = '';
                for ($i = 0; $i <= $nbre; $i++) {
                    $index = rand(0, strlen($characters) - 1);
                    $word .= $characters[$index];
                }

                return $word;
    }

    public static function description_active($id_tarification, $id_description){
        $tarifs=TarifDescrip::where('tarif_id',$id_tarification)
        ->where('descrip_id',$id_description)
        ->get();

        if(count($tarifs)>0){return 1;}
        return 0;
    }

    public static function pas_de_tarification($id_produit, $id_description){
        $tarifs=TarifDescrip::Join('tarifications','tarifications.id','=','tarif_descrip.tarif_id')
        ->where('tarifications.produit_vir_id',$id_produit)
        ->where('tarif_descrip.descrip_id',$id_description)
        ->get('tarif_descrip.id');


        if(count($tarifs)==0){return 1;}
        return 0;
    }
}
?>