<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class UpdateAddressRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'street' => ['nullable', 'string', 'max:100'],
            'number' => ['nullable', 'integer'],
            'postal_code' => ['nullable', 'string', 'max:30'],
            'complement' => ['nullable', 'string', 'max:100'],
            'client_id' => ['required', 'exists:clients,id_client'],
            'city_id' => ['required', 'exists:cities,id_city'],
        ];
    }
}
