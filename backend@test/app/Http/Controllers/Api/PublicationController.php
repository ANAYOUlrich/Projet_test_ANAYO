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
        //Recuperation des publications
        $items = Publication::join('users', 'users.id', '=', 'publications.user_id')
        ->get(['users.name','publications.image','publications.titre','publications.contenu',
        'publications.created_at']); 
        return $items;
    }

    public function store(Request $request){
        //validation
        $this->validate($request, [
            'titre'     => 'required|string|max:100',
            'contenu'   => 'required',
            'image'     => 'file|image|max:2048',
        ]);

        //enregistrement dans le dossier public
        $image=null;
        if($request->hasfile('image')){
            $name = uniqid($request->nom);
            $image = Utils::save_file($request->image,$name ,'images_publication');
        };

        //Enregistrement de publication ds le BD
        Publication::create([
            'titre'     => $request->titre,
            'contenu'   => $request->contenu,
            'image'     => $image,
            'user_id'   => User::getCurrentUser()->id,
        ]);

        //Renvoie de la reponse
        return response()->json([
            'success'=>true,
            'message'=>'Publication enregistrée avec succés',
        ]);
    }
}

