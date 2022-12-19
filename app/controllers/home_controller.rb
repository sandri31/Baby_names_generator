# frozen_string_literal: true

class HomeController < ApplicationController
  require 'baby_name_generator'
  include BabyNameGenerator

  def new
    @baby_names, @name_count = BabyNameGenerator.generate_baby_names
  end

  def description; end
end
