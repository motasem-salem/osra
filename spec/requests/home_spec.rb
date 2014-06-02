require 'spec_helper'

describe 'visiting the homepage' do
  before do
    get_via_redirect '/'
  end

  it 'should show the login page' do
    expect(response.body).to include('Osra Login')
  end
end