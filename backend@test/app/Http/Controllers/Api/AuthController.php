<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Tymon\JWTAuth\Exceptions\JWTException;
use App\User;
use JWTAuth;
use Auth;


class AuthController extends Controller
{
    /**Connexion mobile */
    public function login(REQUEST $request){

        //Validation
        $this->validate($request, [
            'email'     => 'required|email',
            'password'  => 'required',
        ]);

        //Authentification
        $input = $request->only('email', 'password');
        $jwt_token = null;
        if (!$jwt_token = JWTAuth::attempt($input)) {
            return response()->json([
                'success' => false,
                'message' => 'Email et mot de passe incorrect',
            ], 401);
        }
        //Recuperation de l'utilisateur connécté
        $user = Auth::user();
       
        //Renvoie de la reponse
        return response()->json([
            'success' => true,
            'token' => $jwt_token,
            'user' => $user
        ]);
    }

    //Deconnexion
    public function logout(Request $request){
            
        try {
            JWTAuth::invalidate(JWTAuth::parseToken($request->token));
            return response()->json([
                'success' => true,
                'message' => 'Utilisateur deconnecté avec success'
            ]);
        } catch (JWTException $exception) {
            return response()->json([
                'success' => false,
                'message' => 'Sorry, Cet utilisateur ne peut pas se deconnecter'
            ], 500);
        }
    }

    public function getCurrentUser(Request $request){
        $user = JWTAuth::parseToken()->authenticate();
        // add isProfileUpdated....
        $isProfileUpdated=false;
        if($user->isPicUpdated==1 && $user->isEmailUpdated){
            $isProfileUpdated=true;
        }
        $user->isProfileUpdated=$isProfileUpdated;
 
        return $user;
    }
}
