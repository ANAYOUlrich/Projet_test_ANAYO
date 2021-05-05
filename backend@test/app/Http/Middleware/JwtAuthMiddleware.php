<?php

namespace App\Http\Middleware;

use Closure;
use App\User;
use JWTAuth;

class JwtAuthMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle( $request, Closure $next)
    {
        if($request->token){

            try {
                $user = JWTAuth::parseToken()->authenticate();
            } catch (\Throwable $th) {
                return response()->json([
                    'success'   =>false,
                    'message' => 'Le token a expiré'
                ],422);
            }

            return $next($request);
        }else{
            return response()->json([
                'success'   =>false,
                'message' => 'Le token est obligatoire'
            ],422);
        }
    }
}
