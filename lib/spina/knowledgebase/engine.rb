# frozen_string_literal: true

module Spina
  module Knowledgebase
    # Spina::Knowledgebase::Engine
    class Engine < ::Rails::Engine
      isolate_namespace Spina::Knowledgebase

      config.before_initialize do
        ::Spina::Plugin.register do |plugin|
          plugin.name = 'knowledgebase'
          plugin.namespace = 'knowledgebase'
        end
        
        # Add views for purging Tailwind classes
        ::Spina.config.tailwind_content.concat Spina::Knowledgebase::Engine.root.glob("app/views/**/*.*")
      end

      config.generators do |g|
        g.test_framework :rspec, fixture: false
        g.fixture_replacement :factory_bot, dir: 'spec/factories'
        g.assets false
        g.helper false
      end
    end
  end
end
