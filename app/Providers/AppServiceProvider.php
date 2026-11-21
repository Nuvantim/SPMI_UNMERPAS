<?php

namespace App\Providers;

use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        /*
         * enable comment if deployment
         */

        RateLimiter::for('request_limit', function (Request $request) {
            $identifier = $request->user()?->id ?? $request->ip();
            return Limit::perMinute(15)->by($identifier);
        });

        if (env('APP_ENV') === 'production') {
            URL::forceScheme('https');
        }
    }
}
