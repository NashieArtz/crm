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
            'company_name' => ['required', 'string', 'max:100'],
            'email' => [
                'required',
                'email',
                'max:100',
                Rule::unique('clients', 'email')->ignore($clientId, 'id_client')
            ],
            'phone' => ['nullable', 'string', 'max:30'],
            'website' => ['nullable', 'string', 'max:100'],
            'income' => ['nullable', 'integer', 'min:0'],

            'contacts' => 'nullable|array',
            'contacts.*.first_name' => 'required_with:contacts|string|max:255',
            'contacts.*.last_name' => 'required_with:contacts|string|max:255',
            'contacts.*.email' => 'nullable|email|max:255',
            'contacts.*.phone' => 'nullable|string|max:255',
            'contacts.*.type' => 'required_with:contacts|string|in:lead,prospect,customer,partner',
            'contacts.*.description' => 'nullable|string|max:255',
        ];
    }

    // Messages d'erreurs
    public function messages(): array
    {
        return [
            'company_name.required' => 'The name field is required.',
            'name.required' => 'The name field is required.',
            'email.required' => 'The email field is required.',
        ];
    }
}
