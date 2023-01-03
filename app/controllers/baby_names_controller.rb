# frozen_string_literal: true

# This class represents the controller for generating baby names. It includes the `BabyNameGenerator` module
# to generate the names and defines an action `baby_names` that can be called with optional `starts_with`
# and `ends_with` parameters to filter the names by prefix and suffix. The generated names are stored in the
# `@names` instance variable and can be accessed in the corresponding view template.
class BabyNamesController < ApplicationController
  require 'baby_name_generator'
  include BabyNameGenerator

  def baby_names
    required_chars = params[:required_chars].downcase || 'na' # If no value is entered, use 'na' by default
    starts_with = params[:starts_with].downcase
    ends_with = params[:ends_with].downcase

    starts_with = params.fetch(:starts_with, '').downcase
    ends_with = params.fetch(:ends_with, '').downcase

    BabyNameGenerator.instance_variable_set(:@required_global, required_chars.split(' '))
    @names = BabyNameGenerator.generate_baby_generator(starts_with: starts_with, ends_with: ends_with).to_a
  end
end
