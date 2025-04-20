# frozen_string_literal: true

module Spina
  # Spina::Knowledgebase
  module Knowledgebase
    include ActiveSupport::Configurable

    config_accessor :title, :controller, :description, :spina_icon, :plugin_type

    self.title = 'Knowledgebase'
    self.controller = 'knowledgebase'
    self.description = 'Knowledgebase articles'
    self.spina_icon = 'pencil-outline'

    self.plugin_type = 'website_resource'
  end
end
