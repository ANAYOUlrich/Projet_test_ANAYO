<?php

namespace App;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Tymon\JWTAuth\Contracts\JWTSubject;
use JWTAuth;

class User extends Authenticatable implements JWTSubject
{
    use Notifiable;

    protected $fillable = ['name', 'email', 'password',];

    protected $hidden = ['password', 'remember_token',];

    protected $casts = ['email_verified_at' => 'datetime', ];

    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [];
    }

    public static function checkToken($token){
        if($token->token){return true;}
        return false;
    }
    
    public static function getCurrentUser(){
         
        try {
            $user = JWTAuth::parseToken()->authenticate();
            return $user;
        } catch (\Throwable $th) {
            return response()->json([
                'success'   =>false,
                'message' => 'Le token a expiré'
            ],422);
        }
        
    }
}
