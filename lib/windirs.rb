##
# Classes for manipulating paths

module Windirs

  ##
  # Represents a directory path, either absolute or relative.

  class Path

    def initialize path, cygdrive_prefix = '/cygdrive'
      dirs     = '(?<dirs>.*)$'
      windrive = '((?<drive>[A-Z]):)'
      cygdrive = "(#{cygdrive_prefix}/(?<drive>[a-z]))"
      drive    = "(#{windrive}|#{cygdrive})?"
      path_re  = Regexp.new('^' + drive + dirs)

      if path_re =~ path
        m = Regexp.last_match
        @drive = m[:drive]
        @dirs  = m[:dirs]
      end
    end

    def cygwin  prefix = '/cygdrive/'
      fpath('/', prefix){|drive| "#{@drive.downcase}"}
    end

    def nix     prefix = '/'
      fpath('/', prefix){|drive| "#{@drive.downcase}"}
    end

    def rubywin prefix = ''
      fpath('/'){        |drive| "#{@drive.upcase}:"}
    end

    def windows prefix = ''
      fpath('\\'){       |drive| "#{@drive.upcase}:"}
    end

    private

    def fpath del='/', prefix=''
      drive = @drive ? "#{prefix}#{yield(@drive)}" : nil
      "#{drive}#{@dirs}".gsub(/[\/\\\\]/, del)
    end

  end

end
