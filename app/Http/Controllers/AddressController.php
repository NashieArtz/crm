<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreAddressRequest;
use App\Http\Requests\UpdateAddressRequest;
use App\Models\Address;
use Illuminate\Http\RedirectResponse;
use Inertia\Inertia;
use Inertia\Response;

class AddressController extends Controller
{
    public function index(): Response
    {
        $addresses = Address::with(['client:id_client,company_name', 'city:id_city,name'])->latest()->get();

        return Inertia::render('Addresses/Index', [
            'addresses' => $addresses,
        ]);
    }

    public function store(StoreAddressRequest $request): RedirectResponse
    {
        Address::create($request->validated());

        return redirect()->back()->with('success', 'Address created successfully.');
    }

    public function update(UpdateAddressRequest $request, Address $address): RedirectResponse
    {
        $address->update($request->validated());

        return redirect()->back()->with('success', 'Address updated successfully.');
    }

    public function destroy(Address $address): RedirectResponse
    {
        $address->delete();

        return redirect()->back()->with('success', 'Address deleted successfully.');
    }
}
