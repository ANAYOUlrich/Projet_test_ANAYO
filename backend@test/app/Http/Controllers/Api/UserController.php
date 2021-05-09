<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\User;
use JWTAuth;
use Auth;

class UserController extends Controller
{
    public function register(Request $request){
        //Validation des inputs
        $this->validate($request, [
            'name'      => 'required|string|max:100',
            'email'     => 'required|email|max:100|unique:users',
            'password'  => 'required|string|max:50',
            'password_confirmation'  => 'required|string|max:50',
        ]);
        
        //Enregistrement dans la BD
        $user=User::create([
            'name'=>request('name'),
            'email'=>request('email'),
            'password'=>bcrypt(request('password'))
        ]);

        //Authentification de l'utilisateur
        $input = $request->only('email', 'password');
        $jwt_token = null;
        if (!$jwt_token = JWTAuth::attempt($input)) {
            return response()->json([
                'success' => false,
                'message' => 'Email et mot de passe incorrect',
            ], 401);
        }

        //renvoi de la reponse
        return response()->json([
            'success'=>true,
            'message'=>'Utilisateur enregistrée avec succés',
            'token' => $jwt_token,
            'user'=>$user,
        ]);
    }
}
