##
# Classes for manipulating paths

module Windirs

  class Path

    def initialize path, cygdrive_prefix = '/cygdrive'
      dirs     = '(?<dirs>[/\\\].*)$'
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

    def cygwin cygdrive_prefix = '/cygdrive'
      drive = @drive ? "#{cygdrive_prefix}/#{@drive.downcase}" : nil
      "#{drive}#{@dirs}".gsub('\\', '/')
    end

    def rubywin
      drive = @drive ? "#{@drive.upcase}:" : nil
      "#{drive}#{@dirs}".gsub('\\', '/')
    end

    def windows
      drive = @drive ? "#{@drive.upcase}:" : nil
      "#{drive}#{@dirs}".gsub('/', '\\')
    end

    def nix nix_prefix = ''
      drive = @drive ? "#{nix_prefix}/#{@drive.downcase}" : nil
      "#{drive}#{@dirs}".gsub('\\', '/')
    end

  end

end
