# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper Playbook::PbKitHelper
  before_action :set_date

  def home; end

  private

  def set_date
    @date = Time.use_zone("America/New_York") { Date.current.strftime("%A") }
  end
end
