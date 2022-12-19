# frozen_string_literal: true

class LettersController < ApplicationController
  require 'baby_name_generator'
  include BabyNameGenerator

  def show
    @letter = params[:letter]
    @baby_names, @name_count = BabyNameGenerator.generate_baby_names

    @baby_names = @baby_names.select { |name| name.start_with?(@letter) }
    @name_count = @name_count.select { |name| name.start_with?(@letter) }
  end
end
