<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ClientRequest extends FormRequest
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
        // Get id client si on est sur la route pour update
        $clientId = $this->route('client') ? $this->route('client')->id_client : null;
        return [
            'company_name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'email', 'max:255', Rule::unique('clients', 'email')->ignore($clientId, 'id_client')],
            'phone' => ['nullable', 'string', 'max:255'],
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
            'website' => ['nullable', 'string', 'max:500'],
=======
            'address' => ['nullable', 'string', 'max:500'],
>>>>>>> bd64d29 (feat: CRUD client)
=======
            'website' => ['nullable', 'string', 'max:500'],
>>>>>>> 2be1091 (feat: CRUD client)
=======
            'website' => ['nullable', 'string', 'max:500'],
>>>>>>> f2605f16a9741743c9e9c2cb6727c7b3d05c1b61
            'income' => ['nullable', 'integer', 'min:0'],
        ];
    }

    // Messages d'erreurs
    public function messages(): array {
        return [
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
            'company_name.required' => 'The name field is required.',
=======
            'name.required' => 'The name field is required.',
>>>>>>> bd64d29 (feat: CRUD client)
=======
            'company_name.required' => 'The name field is required.',
>>>>>>> 2be1091 (feat: CRUD client)
=======
            'company_name.required' => 'The name field is required.',
>>>>>>> f2605f16a9741743c9e9c2cb6727c7b3d05c1b61
            'email.required' => 'The email field is required.',
        ];
    }
}
