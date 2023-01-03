# frozen_string_literal: true

class BabyNamesController < ApplicationController
  require 'baby_name_generator'
  include BabyNameGenerator

  def baby_names
    required_chars = params[:required_chars].downcase || 'na' # If no value is entered, use 'na' by default
    starts_with = params[:starts_with].downcase
    ends_with = params[:ends_with].downcase

    BabyNameGenerator.instance_variable_set(:@required_global, required_chars.split(' '))

    @names = BabyNameGenerator.generate_baby_generator(starts_with: starts_with, ends_with: ends_with).to_a
  end
end
