<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateActivityRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'title' => ['required', 'string', 'max:150'],
            'description' => ['nullable', 'string'],
            'type' => ['required', Rule::in(['call', 'email', 'meeting', 'task'])],
            'status' => ['required', Rule::in(['pending', 'completed', 'cancelled'])],
            'activity_date' => ['required', 'date'],
            'client_id' => ['required', 'exists:clients,id_client'],
        ];
    }
}
