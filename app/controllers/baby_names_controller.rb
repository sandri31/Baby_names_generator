# frozen_string_literal: true

class BabyNamesController < ApplicationController
  require 'baby_name_generator'
  include BabyNameGenerator

  def baby_names
    starts_with = params[:starts_with]
    ends_with = params[:ends_with]

    @names = BabyNameGenerator.generate_baby_generator(starts_with: starts_with, ends_with: ends_with).to_a
  end
end
