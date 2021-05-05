<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\User;

class UserController extends Controller
{
    public function register(Request $request){
        $user_verifie=User::where('email',request('email'))->first();
        if ($user_verifie) {
            return response()->json([
                'success'=>false,
                'message'=>'Cet utilisateur existe deja',
                'user'=>$user_verifie
            ]);
        }
        
        $user=User::create([
            'name'=>request('name'),
            'email'=>request('email'),
            'password'=>bcrypt(request('password'))
        ]);

        return response()->json([
            'success'=>true,
            'message'=>'Utilisateur enregistrée avec succés',
            'user'=>$user
        ]);
    }
}
