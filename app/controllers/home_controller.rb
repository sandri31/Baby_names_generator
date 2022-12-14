# frozen_string_literal: true

class HomeController < ApplicationController
  def new
    system("echo 'ruby lib/baby_names_generator.rb'")

    @script_baby_names = `ruby lib/baby_names_generator.rb`
  end
end
