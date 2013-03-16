module Md
  class Helper
    def self.extract_metadata(md)
      yaml_to_hash match_data(md, 1)
    rescue
      {}
    end

    def self.extract_markdown(md)
      match_data(md, 2)
    rescue
      ""
    end

    def self.yaml_to_hash(yaml)
      YAML::load(yaml)
    end

    def self.match_data(md, index)
      md.match(/-{3,}\s([\s\S]*?)-{3,}\s([\s\S]*)/)[index]
    end

    
  end
end