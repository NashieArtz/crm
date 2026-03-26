<?php

namespace App\Http\Controllers;

abstract class Controller
{
    public function formatPrice(int $price): string
    {
        return number_format($price, 2, '.', ',').'€';
    }
}
