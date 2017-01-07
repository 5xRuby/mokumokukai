# Require core library
require 'redcarpet'
require 'json'

require 'middleman-core'
require 'job-parser/list'

# Extension namespace
module JobParser
  class Extension < ::Middleman::Extension
    option :root, Dir.pwd, 'The job data root'

    expose_to_template :job_list

    def initialize(app, options_hash={}, &block)
      super

      @root = options.root
    end

    def after_configuration

    end

    def readme_file
      "#{@root}/README.md"
    end

    def job_files
      "#{@root}/jobs/*.md"
    end

    def job_list
      List.load(readme_file)
    end

  end
end
