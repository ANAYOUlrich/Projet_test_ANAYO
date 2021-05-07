<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Publication;
use App\User;
use App\Utils\Utils;

class PublicationController extends Controller
{
    public function index(){ 
        $items = Publication::join('users', 'users.id', '=', 'publications.user_id')->get(); 
        return $items;
    }

    public function store(Request $request){
        
        $this->validate($request, [
            'titre'     => 'required',
            'contenu'   => 'required',
            'image'     => '',
        ]);

        $image=null;
        if($request->hasfile('image')){
            $name = uniqid($request->nom);
            $image = Utils::save_file($request->image,$name ,'images_publication');
        };

        Publication::create([
            'titre'     => $request->titre,
            'contenu'   => $request->contenu,
            'image'   => $image,
            'user_id'   => User::getCurrentUser()->id,
        ]);

        return response()->json([
            'success'=>true,
            'message'=>'Publication enregistrée avec succés',
        ]);
    }
}

