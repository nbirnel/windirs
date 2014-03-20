require  "#{File.dirname(__FILE__)}/../lib/windirs"

describe Windirs do
  before do
    dpath_strings = {
      :cygpath  => '/cygdrive/c/Users/joe/Desktop',
      :winpath  => 'C:\Users\joe\Desktop',
      :rubypath => 'C:/Users/joe/Desktop',
    }
    @dpaths = Hash.new
    dpath_strings.map{|k, v| @dpaths[k] = Windirs::Path.new(v)}

    upath_strings = {
      :unc      => '\\windomain\somedir\file',
      :cygunc   => '//windomain/somedir/file',
    }
    @upaths = Hash.new
    upath_strings.map{|k, v| @upaths[k] = Windirs::Path.new(v)}
  end

  describe Windirs::Path do

    it 'converts from windows drive' do
      @dpaths[:winpath].cygwin.should eq '/cygdrive/c/Users/joe/Desktop'
    end

  end

end
