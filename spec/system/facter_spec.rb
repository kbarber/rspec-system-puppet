require 'spec_helper_system'

describe "helper facter" do
  it 'domain fact should return something valid' do
    facter do |r|
      r.stderr.should == ''
      r.facts['domain'].should =~ /[a-z]+/
      r.exit_code.should == 0
    end
  end

  it 'fqdn fact should return something valid' do
    facter do |r|
      r.stderr.should == ''
      r.facts['fqdn'].should =~ /vm/
      r.exit_code.should == 0
    end
  end

  it 'puppet option should return valid myfact fact' do
    facter(:puppet => true) do |r|
      r.stderr.should == ''
      r.facts['myfact'].should =~ /myfact/
      r.exit_code.should == 0
    end
  end

  context 'test as a subject' do
    context facter do
      its(:stderr) { should == '' }
      its(:exit_code) { should == 0 }

      it { subject.facts['fqdn'].should =~ /vm/ }
    end
  end
end
