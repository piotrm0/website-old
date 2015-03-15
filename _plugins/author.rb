require 'optparse'

def read_authors(authors)
  ret = Hash.new()
  for keyfield in ['username', 'name'] do
    temp = Hash.new()
    for author in authors do
      temp[author[keyfield]] = author
    end
    ret[keyfield] = temp
  end
  ret
end

module BibStore
  class AuthorTag < Liquid::Tag

    @@field = nil

    def initialize(tag_name, arguments, tokens)
      super
      
      @keyfield = "username"

      if @@field
        @field = @@field
      else
        @field = 'name'
      end

      opt_parser = OptionParser.new do |opts|
        opts.on('--byname') do
          @keyfield = "name"
        end
        opts.on('-u', '--username') do
          @field = 'username'
        end
        opts.on('-n', '--name') do
          @field = 'name'
        end
        opts.on('-w', '--website') do
          @field = 'website'
        end
        opts.on('-e', '--email') do
          @field = 'email'
        end
        opts.on('-i', '--icon') do
          @field = 'icon'
        end
      end
      tokens = arguments.strip.split(/\s+/)

      @args = tokens.take_while { |a| not a.start_with?('-') }
      opts = (tokens - @args)

      opt_parser.parse!(opts)

      if @args.size() == 0
        @@field = @field
        @field = nil
      end
    end

    def authors(context)
      @@authors ||= read_authors(context['site.data.authors'])
    end

    def render(context)
      if not @field
        return ""
      end

      temp = authors(context)[@keyfield]

      return @args.map { |key|
        realkey = Liquid::Template.parse(key).render context

        if not temp.has_key?(realkey)
          return "unknown author: " + realkey
        else
          author = temp[realkey]
          return author[@field]
        end
      }.join("")
    end
  end
end

Liquid::Template.register_tag('author', BibStore::AuthorTag)
