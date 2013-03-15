module Kitana
  module Common
    def set_config(config)
      return if !config.respond_to?(:each)
      config.each do |option, value|
        send("#{option}=", value) if respond_to?("#{option}=")
      end
    end
    
    def read_config
      load_path = "#{path}/#{config_path}"      
      YAML::load( File.open(load_path) )  if File.exists?(load_path)
    end

    def config_path
      "_config.yml"
    end

    def inject_and_create(path, klass)
      Dir[path].inject([]) { |memo, inject_path|
        memo << klass.new(inject_path)
      }
    end
  end
end