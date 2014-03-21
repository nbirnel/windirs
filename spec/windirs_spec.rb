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

    @uncs = {
      :windows => '\\\\windomain\somedir\file',
      :cygwin  => '//windomain/somedir/file',
      :rubywin => '//windomain/somedir/file',
      :nix     => '//windomain/somedir/file',
    }
    @upaths = Hash.new
    @uncs.map{|k, v| @upaths[k] = Windirs::Path.new(v)}

  end

  describe Windirs::Path do

    it 'converts any drive to any drive' do 
      @drives.keys.repeated_permutation(2).each do |from, to|
        puts "converts from #{from} to #{to}"
        @dpaths[from].method(to).call.should eq @drives[to]
      end
    end

    it 'fakes a drive letter to *nix' do
      @drives.keys.each do |from|
        puts "fake drive letter from #{from} to *nix"
        @dpaths[from].nix.should eq '/c/Users/joe/Desktop'
      end
    end

    it 'converts any unc to any unc' do 
      @uncs.keys.repeated_permutation(2).each do |from, to|
        puts "converts from #{from} to #{to}"
        @upaths[from].method(to).call.should eq @uncs[to]
      end
    end

    it 'converts relative paths' do
      pending
    end

    it 'converts path fragments' do
      pending
    end

  end

end
