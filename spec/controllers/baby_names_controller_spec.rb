# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BabyNamesController, type: :controller do
  describe 'GET #baby_names' do
    it 'returns a success response and generates baby names with given prefix and suffix' do
      get :baby_names, params: { starts_with: 'a', ends_with: 'y' }
      expect(response).to be_successful
      expect(assigns(:names)).to_not be_empty
    end

    it 'returns a success response and generates baby names with given prefix only' do
      get :baby_names, params: { starts_with: 'a' }
      expect(response).to be_successful
      expect(assigns(:names)).to_not be_empty
    end

    it 'returns a success response and generates baby names with given suffix only' do
      get :baby_names, params: { ends_with: 'y' }
      expect(response).to be_successful
      expect(assigns(:names)).to_not be_empty
    end
  end
end
