<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StoreActivityRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'type' => ['required', 'string', 'in:call,email,meeting,task,note'],
            'description' => ['required', 'string'],
            'date_activity' => ['required', 'date'],
            'client_id' => ['required', 'exists:clients,id_client'],
        ];
    }
}
