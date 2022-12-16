# frozen_string_literal: true

class LettersController < ApplicationController
  def show
    @letter = params[:letter]
  end
end
