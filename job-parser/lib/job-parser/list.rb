require 'redcarpet'
require 'json'

module JobParser
  class List < Redcarpet::Render::Base
    PEOPLE_PATTERN = /\[(.+?)\]\(.+?\)\s-\s(.+?)\s*\((.+?)\)/
    KEYWORDS = {
      find_people: "依英文字母順序排序"
    }

    def self.load(file)
      @md ||= Redcarpet::Markdown.new(List)
      @md.render(File.read(file))
      @md.renderer.as_object
    end

    def initialize
      super
      @list = []
    end

    def list_item(content, type)
      create_job_info(content.strip)
      ""
    end

    def create_job_info(item)
      item.scan(PEOPLE_PATTERN) do |company, title, offer|
        @list << {company: company, title: title, offer: offer}
      end
    end

    def postprocess(result)
      @list.to_json
    end

    def as_object
      @list
    end
  end
end
