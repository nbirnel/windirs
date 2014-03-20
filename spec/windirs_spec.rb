require  "#{File.dirname(__FILE__)}/../lib/windirs"

describe Windirs do

  before do
    @drives = {
      :cygwin  => '/cygdrive/c/Users/joe/Desktop',
      :windows => 'C:\Users\joe\Desktop',
      :rubywin => 'C:/Users/joe/Desktop',
    }
    @dpaths = Hash.new
    @drives.map{|k, v| @dpaths[k] = Windirs::Path.new(v)}

    @unc = {
      :unc      => '\\windomain\somedir\file',
      :cygunc   => '//windomain/somedir/file',
    }
    @upaths = Hash.new
    @unc.map{|k, v| @upaths[k] = Windirs::Path.new(v)}

  end

  describe Windirs::Path do

    it 'converts from windows to cygwin' do
      @dpaths[:windows].cygwin.should eq @drives[:cygwin]
    end

    it 'converts from windows to rubywin' do
      @dpaths[:windows].rubywin.should eq @drives[:rubywin]
    end

   # it 'converts everything' do
   #   @drives.keys.repeated_permutation(2).each do |from, to|
   #     puts "converts from #{from} to #{to}"
   #     @dpaths[from].method(to).call.should eq @drives[to]
   #   end
   # end

  end

end
