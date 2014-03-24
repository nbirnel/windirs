##
# Classes for representing directory paths in various formats. 

module Windirs

  ##
  # Represents a directory path, either absolute or relative.
  #
  # This Class is meant to be used when you are uncertain where your 
  # program will be running.
  #
  # For instance, 
  # if you want to make windows shortcuts with win32-shortcut
  # http://rubygems.org/gems/win32-shortcut
  # you will need a windows style path. 
  # But if you don't know the location until run-time,
  # and you are uncertain if you are running in Cygwin or native Ruby,
  # you could use:
  #     s.path = Windirs::Path.new(Dir.pwd).windows
  #
  # BUGS
  # ----------------
  # Does not dereference Cygwin mount points to Windows drives.
  # This is arguably not a bug,
  # but a feature not yet implemented.
  #
  # Ditto for dereferencing Windows network mounts to UNC paths.
  #


  class Path

    ##
    # Create a new Path from +path+.
    #
    #     > winpath = Windirs::Path.new 'C:\Users\noah\Desktop'
    #     > nixpath = Windirs::Path.new '/bin/ls'
    #     > cygpath = Windirs::Path.new '/cygdrive/c/Users/noah/Desktop'
    #
    # You probably don't need to know the rest of this:
    # +cygdrive_prefix+ defaults to '/cygdrive/',
    # and is used to extract drive letters from Cygwin-ish looking paths.
    # If you know will not be using Cygwin paths, 
    # you may wish to assign this to ''.
    # If your cygdrive path prefix is something else, 
    # you should assign this appropriately.
    # See 
    # http://cygwin.com/cygwin-ug-net/using.html#cygdrive
    # for details.
    # Note that we are using a trailing slash,
    # unlike the Cygwin documentation.
    #

    def initialize path, cygdrive_prefix = '/cygdrive/'
      dirs     = '(?<dirs>.*)$'
      windrive = '((?<drive>[A-Z]):)'
      cygdrive = "(#{cygdrive_prefix}(?<drive>[a-z]))"
      drive    = "(#{windrive}|#{cygdrive})?"
      path_re  = Regexp.new('^' + drive + dirs)

      if path_re =~ path
        m = Regexp.last_match
        @drive = m[:drive]
        @dirs  = m[:dirs]
      end
    end

    ##
    # Return a Cygwin style path String. 
    # See Windirs.Path.initialize documentation 
    # for more info on +cygdrive_prefix+.
    #
    #    > winpath.cygwin
    #    => "/cygdrive/c/Users/noah/Desktop"

    def cygwin  cygdrive_prefix = '/cygdrive/'
      fpath('/', cygdrive_prefix){|drive| "#{@drive.downcase}"}
    end

    ##
    # Return a *nix (Linux, Mac OS X, *BSD) style path String.
    # +prefix+ will be used if a drive was detected in Path,
    # but this is unlikely to be useful. 
    # You may want to assign it for certain Samba situations,
    # but I have little opinion or knowledge on that.
    #
    #    > winpath.nix
    #    => "/c/Users/noah/Desktop"

    def nix     prefix = '/'
      fpath('/', prefix){|drive| "#{@drive.downcase}"}
    end

    ##
    # Return a Ruby on Windows style path String.
    #
    #    > winpath.rubywin
    #    => "C:/Users/noah/Desktop"

    def rubywin 
      fpath('/'){        |drive| "#{@drive.upcase}:"}
    end

    ##
    # Return a Windows style path String.
    #
    #    > cygpath.windows
    #    => "C:\\Users\\noah\\Desktop"
    #    > puts cygpath.windows
    #    "C:\Users\noah\Desktop"
    #    => nil

    def windows
      fpath('\\'){       |drive| "#{@drive.upcase}:"}
    end

    ##
    # Return a new Windirs::Path with any Windows network mapped drives
    # dereferenced to their UNC.
    # Returns +self+ if not on Windows, or
    # +self+ is not on a network mapped drive.
    
    def win_deref
      return self unless ENV['OS'] == 'Windows_NT'

      # FIXME try to get path to net if on Cygwin and can't see net
      net_use = `net use #{@drive}:`
      return self unless $?.exitstatus == 0
      remote_line  = net_use.split("\r\n").select{|l| l =~ /^Remote name\s*/}
      drive = @drive
      drive = remote_line[0].sub(/^Remote name\s*/, '')
      Path.new "#{drive}#{@dirs}"
    end
    
#    #FIXME will need to stub or mock this to test properly?
#    def cyg_deref
#       
##    C:/cygwin/bin on /usr/bin type ntfs (binary,auto)
#      
#      return self if ENV['OS'] != 'Windows_NT'
#
#      as_nix = self.nix
#
#      #FIXME use mount similarly, with similar caveats to net use
#      mounts = `mount`.split("\n")
#      mh = Hash.new
#      mounts.map do |l| 
#        l =~ /^(?<device>.*)\s+on\s+(?<mountpoint>.*)\s+type\s+.*$/
#        m = Regexp.last_match
#        mh[m[:device]] = m[:mountpoint]
#      end
#
#
#      sorted = mh.sort_by{|k,v| v.length}
#
#      sorted.each do |el|
#        #if el[1] matches as_nix, replace that with el[0]
#      end
#
#
#    end
#

    private

    def fpath delim='/', prefix=''
      drive = @drive ? "#{prefix}#{yield(@drive)}" : nil
      "#{drive}#{@dirs}".gsub(/[\/\\\\]/, delim)
    end

  end

end
