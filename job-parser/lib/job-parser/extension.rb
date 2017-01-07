# Require core library
require 'redcarpet'
require 'json'

require 'middleman-core'
require 'job-parser/list'

# Extension namespace
module JobParser
  class Extension < ::Middleman::Extension
    option :root, Dir.pwd, 'The job data root'

    def initialize(app, options_hash={}, &block)
      super

      @root = options.root
      @list = []
    end

    def after_configuration
      @list = List.load(readme_file)
    end

    def readme_file
      "#{@root}/README.md"
    end

    def job_files
      "#{@root}/jobs/*.md"
    end

    helpers do
      def job_list_json
        @list.to_json
      end
    end
  end
end
