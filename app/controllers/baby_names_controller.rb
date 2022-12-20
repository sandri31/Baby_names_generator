# frozen_string_literal: true

class BabyNamesController < ApplicationController
  require 'baby_name_suggestion'
  include BabyNameSuggestion

  def baby_names
    starts_with = params[:starts_with]
    ends_with = params[:ends_with]

    @names = BabyNameSuggestion.generate_baby_suggestions(starts_with: starts_with, ends_with: ends_with).to_a
  end
end
