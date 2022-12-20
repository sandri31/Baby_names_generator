# frozen_string_literal: true

class HomeController < ApplicationController
  require 'baby_name_generator'
  include BabyNameGenerator

  def description; end
end
