<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ActivityRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'type' => ['nullable', 'in:call,email,meeting,task,note'],
            'description' => ['nullable', 'string'],
            'date_activity' => ['required', 'date'],
            // table pivot
            'client_ids' => ['required', 'array'],
            'client_ids.*' => ['exists:clients,id_client'],
        ];
    }
}
