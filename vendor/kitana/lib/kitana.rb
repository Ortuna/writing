module Kitana
  module Common
    def set_config(config)
      return if !config.respond_to?(:each)
      config.each do |option, value|
        send("#{option}=", value) if respond_to?("#{option}=")
      end
    end
    
    def read_config
      yaml_file_to_hash "#{path}/#{config_path}"
    end

    def config_path
      "_config.yml"
    end

    def inject_and_create(path, klass)
      Dir[path].inject([]) { |memo, inject_path|
        memo << klass.new(inject_path)
      }
    end

    ###
    ## Should give the basename for the path
    #
    def basename
      File.basename(path)
    end

    private
    def yaml_file_to_hash(file_path)
      config_hash = YAML::load(File.open(file_path))
      return config_hash ? config_hash : {}
    rescue
      return {}
    end
  end
end