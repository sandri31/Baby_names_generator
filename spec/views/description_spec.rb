# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe 'home/description.html.erb', type: :view do
  describe 'Baby name form' do
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

    it 'redirects to the baby names page' do
      visit root_path
      fill_in 'starts_with', with: 'A'
      fill_in 'ends_with', with: '2'
      click_button 'Générer'
      expect(page).to have_current_path '/baby_names?starts_with=A&ends_with=2&commit=Générer', wait: 10
      expect(page).to have_content 'A'
    end
  end
end
