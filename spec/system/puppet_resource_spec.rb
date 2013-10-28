require 'spec_helper_system'

describe "helper puppet_resource" do
  it 'for "user" should returns an exit code of 0' do
    puppet_resource('user') do |r|
      r.stderr.should == ''
      r.exit_code.should == 0
    end
  end

  context 'test as a subject' do
    context puppet_resource 'user' do
      its(:stdout) { should_not == '' }
      its(:stderr) { should == '' }
      its(:exit_code) { should == 0 }
    end
  end
end
