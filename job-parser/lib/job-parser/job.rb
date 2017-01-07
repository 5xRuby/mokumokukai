require 'redcarpet'
require 'json'

module JobParser
  class Job < Redcarpet::Render::Base
    KEYWORDS = {
      skill: "技能" ,
      good_at: "加分條件",
      offer: "待遇",
      location: "地點",
      contact: "聯絡",
      content: "工作內容"
    }

    def initialize
      super

      @job = {
        company: nil,
        title: nil,
        skill: [],
        good_at: [],
        offer: [],
        contact: nil,
        content: nil,
        location: nil
      }

      @ptr = nil
    end

    def paragraph(text)
      case @ptr
      when :offer, :skill, :good_at
        @job[@ptr].unshift(text)
      when :location, :contact, :content
        @job[@ptr] = text
      end
      ""
    end

    def header(title, level)
      @ptr = nil
      @job[:company], @job[:title] = title.split(' - ') if level == 1
      @ptr = KEYWORDS.invert[title]
      ""
    end

    def list_item(content, type)
      @job[@ptr] << content.strip unless @ptr.nil?
      ""
    end

    def postprocess(result)
      @job.to_json
    end
  end
end
