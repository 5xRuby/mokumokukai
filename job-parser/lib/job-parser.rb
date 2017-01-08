require "middleman-core"

Middleman::Extensions.register :job_parser do
  require "job-parser/extension"
  JobParser::Extension
end
