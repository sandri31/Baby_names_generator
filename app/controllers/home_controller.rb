# frozen_string_literal: true

class HomeController < ApplicationController
  def new; end

  def my_action
    @result = system('rails bin:baby_names_generator.rb')
  end
end
