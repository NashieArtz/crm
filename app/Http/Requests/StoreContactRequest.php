<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class StoreContactRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'first_name' => ['required', 'string', 'max:100'],
            'last_name'  => ['required', 'string', 'max:100'],
            'email'      => ['nullable', 'email', 'max:150'],
            'phone'      => ['nullable', 'string', 'max:50'],
            'job_title'  => ['nullable', 'string', 'max:100'],

            // Vérifie l'ID client envoyé dans table clients
            'client_id'  => ['required', 'exists:clients,id_client'],
        ];
    }
}
