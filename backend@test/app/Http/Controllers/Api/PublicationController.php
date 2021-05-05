<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Publication;
use App\User;

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
        ]);

        Publication::create([
            'titre'     => $request->titre,
            'contenu'   => $request->contenu,
            'user_id'   => User::getCurrentUser()->id,
        ]);

        return response()->json([
            'success'=>true,
            'message'=>'Publication enregistrée avec succés',
        ]);
    }
}
