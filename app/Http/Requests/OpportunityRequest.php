<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class OpportunityRequest extends FormRequest
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
            'source' => ['nullable', 'string', 'max:150'],
            'details' => ['nullable', 'string'],
            'status' => ['required', 'in:qualification,proposal,negotiation,closed_won,closed_lost'],
            'type' => ['required', 'in:new_business,upsell,renewal'],
            'amount' => ['nullable', 'numeric', 'min:0'],
            'closed_date' => ['required', 'date', 'date_format:Y-m-d'],
            'client_id' => ['required', 'exists:clients,id_client'],
        ];
    }

    public function messages(): array
    {
        return [
            'client_id.exists' => 'Le client sélectionné est introuvable.',
            'status.in' => 'Ce statut n\'est pas reconnu par le pipeline.',
            'type.in' => 'Ce type d\'opportunité n\'est pas valide.',
            'closed_date.required' => 'La date de clôture estimée est obligatoire.',
        ];
    }
}
