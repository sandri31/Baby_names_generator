# frozen_string_literal: true

class BabyNamesController < ApplicationController
  require 'baby_name_generator'
  include BabyNameGenerator

  def baby_names
    starts_with = params[:starts_with].downcase
    ends_with = params[:ends_with].downcase

    @names = BabyNameGenerator.generate_baby_generator(starts_with: starts_with, ends_with: ends_with).to_a
  end

  def update_required_chars
    BabyNameGenerator.required_global = params[:required_chars].split(' ')
    redirect_to home_path
  end
end
