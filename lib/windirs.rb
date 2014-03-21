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

    #FIXME will need to stub or mock this to test properly?
    #def win_deref
    #  net_use = `net use #{@drive}:`
    #  # FIXME check to see if we are on window-ish OS
    #  # FIXME try to get path to net if on Cygwin and can't see net
    #  # FIXME super stupid
    #  remote  = net_use.split("\r\n").select do |l| 
    #    l =~ /^Remote name\s*/ 
    #  end[0].sub(/^Remote name\s*/, '')
    #  @drive = nil
    #  @dirs = "#{remote}/#{@dirs}"
    #end
    
    #FIXME will need to stub or mock this to test properly?
    #def cyg_deref
    #  FIXME use mount similarly, with similar caveats to net use
    #  m = `mount`.split("\n").map do |l| 
    #    l =~ /^(?<dev>.*)\s+on\s+(?<mountp>.*)\s+type\s+.*$/
    #  end
    #C:/cygwin/bin on /usr/bin type ntfs (binary,auto)
    #C:/cygwin/lib on /usr/lib type ntfs (binary,auto)
    #C:/cygwin on / type ntfs (binary,auto)
    #C: on /cygdrive/c type ntfs (binary,posix=0,user,noumount,auto)
    #R: on /cygdrive/r type ntfs (binary,posix=0,user,noumount,auto)
    #S: on /cygdrive/s type ntfs (binary,posix=0,user,noumount,auto)
    #end


    private

    def fpath del='/', prefix=''
      drive = @drive ? "#{prefix}#{yield(@drive)}" : nil
      "#{drive}#{@dirs}".gsub(/[\/\\\\]/, del)
    end

  end

end
