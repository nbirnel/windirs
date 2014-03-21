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
      cygdrive = @drive ? "#{cygdrive_prefix}/#{@drive.downcase}" : nil
      dirs = @dirs.gsub '\\', '/'
      "#{cygdrive}#{dirs}"
    end

    def rubywin
      return nil unless @drive
      dirs = @dirs.gsub '\\', '/'
      "#{@drive.upcase}:#{dirs}"
    end

    def windows
      return nil unless @drive
      dirs = @dirs.gsub '/', '\\'
      "#{@drive.upcase}:#{dirs}"
    end

  end

end
