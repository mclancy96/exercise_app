# frozen_string_literal: true

class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper Playbook::PbKitHelper
  def home; end
end
