require 'spec_helper_system'

describe "helper puppet_agent" do
  it 'should run without error' do
    puppet_agent do |r|
      r.stderr.should == ''
      r.exit_code.should == 0
    end
  end

  context 'test as a subject' do
    context puppet_agent do
      its(:stderr) { should == '' }
      its(:exit_code) { should == 0 }
    end
  end
end
