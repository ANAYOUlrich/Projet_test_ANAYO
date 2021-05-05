<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/', function () {return "Le test";});

//Auth api 
Route::post('login','Api\AuthController@login');
Route::post('logout','Api\AuthController@logout')->middleware('App\Http\Middleware\JwtAuthMiddleware');
Route::get('current_user', 'Api\AuthController@getCurrentUser')->middleware('App\Http\Middleware\JwtAuthMiddleware');

//Enregistrer un utilisateur
Route::post('user/register','Api\UserController@register');

//Route qui ont besoin d'authentification
Route::group(['prefix' => 'publication'], function () {
    Route::get('/', 'Api\PublicationController@index');
    Route::post('store', 'Api\PublicationController@store')->middleware('App\Http\Middleware\JwtAuthMiddleware');
});

