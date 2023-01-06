# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe 'Baby name form_with' do
  include Capybara::DSL

  it 'renders the form' do
    visit root_path
    expect(page).to have_selector 'form'
  end

  it 'renders the form fields' do
    visit root_path
    expect(page).to have_field 'starts_with'
    expect(page).to have_field 'ends_with'
    expect(page).to have_selector 'label', text: 'Lettre(s) de début :'
    expect(page).to have_selector 'label', text: 'Lettre(s) de fin :'
  end

  it 'renders the submit button' do
    visit root_path
    expect(page).to have_button 'Générer'
  end

  it 'Check that the fields starts_with and ends_with exist' do
    visit root_path
    fill_in 'starts_with', with: 'A'
    fill_in 'ends_with', with: 'A'
    click_button 'Générer'
  end

  it 'Check number it required_chars' do
    visit root_path
    fill_in 'required_chars', with: '123'
    click_button 'Générer'
    expect(page).to have_current_path('/baby_names?required_chars=123&starts_with=&ends_with=&commit=Générer')
  end

  it 'Check number in starts_with' do
    visit root_path
    fill_in 'starts_with', with: '12'
    click_button 'Générer'
    expect(page).to have_current_path('/baby_names?required_chars=na&starts_with=12&ends_with=&commit=Générer')
  end

  it 'Check number in ends_with' do
    visit root_path
    fill_in 'ends_with', with: '8'
    click_button 'Générer'
    expect(page).to have_current_path('/baby_names?required_chars=na&starts_with=&ends_with=8&commit=Générer')
  end

  it 'Check path with required_chars' do
    visit root_path
    fill_in 'required_chars', with: 'bar'
    click_button 'Générer'
    expect(page).to have_current_path('/baby_names?required_chars=bar&starts_with=&ends_with=&commit=Générer')
    expect(page).to have_content 'A : 4'
  end

  it 'Check path with starts_with' do
    visit root_path
    fill_in 'starts_with', with: 'A'
    fill_in 'ends_with', with: ''
    click_button 'Générer'
    expect(page).to have_current_path('/baby_names?required_chars=na&starts_with=A&ends_with=&commit=Générer')
    expect(page).to have_content 'A : 228'
  end

  it 'Check path with ends_with' do
    visit root_path
    fill_in 'starts_with', with: ''
    fill_in 'ends_with', with: 'a'
    click_button 'Générer'
    expect(page).to have_current_path('/baby_names?required_chars=na&starts_with=&ends_with=a&commit=Générer')
    expect(page).to have_content 'A : 73'
  end
end

describe 'Test button section about' do
  include Capybara::DSL

  it 'Check that the button about exists' do
    visit root_path
    expect(page).to have_selector(:css, 'a.btn.btn-xl.btn-outline-dark[href="https://pastebin.com/NkQrnugq"]',
                                  text: "Voir l'algorithme")
  end
end

describe 'Test footer links' do
  include Capybara::DSL

  it 'Check that the footer links exist' do
    visit root_path
    expect(page).to have_selector(:css, 'a[href="https://github.com/hgueguen"]', text: 'Harry JMG')
    expect(page).to have_selector(:css, 'a[href="https://github.com/Symitsh"]')
    expect(page).to have_selector(:css, 'a[href="https://github.com/Lauris-Bessone"]')
    expect(page).to have_selector(:css, 'a[href="https://getbootstrap.com/"]', text: 'Bootstrap')
    expect(page).to have_selector(:css, 'a[href="https://github.com/Symitsh/Baby_names_generator"]',
                                  text: 'BABY NAME GENERATOR')
  end
end
