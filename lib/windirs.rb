##
# Classes for manipulating paths

module Windirs

  class Path

    def initialize path, cygdrive_prefix = '/cygdrive'
      drive_re = Regexp.new '^((?<drive>[A-Z]):)?(?<dirs>[/\\\].*)$'

      if drive_re =~ path
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

    def ruby_win
    end

    def windows
    end

  end

end
