require 'spec_helper_system'

RSpec::Matchers.define :be_idempotent do
  match_for_should do |thing|
    return false unless thing.is_a?(RSpecSystemPuppet::Helpers::PuppetApply)
    thing.refresh
    thing.stderr.should be_empty
    thing.exit_code.should be_zero
  end


  match_for_should_not do |thing|
    #return false unless thing.is_a?(RSpecSystemPuppet::Helpers::PuppetApply)
    thing.refresh
    thing.exit_code.should be_zero
  end

  failure_message_for_should_not do |actual|
    "expected that #{actual.opts[:code]} would not be idempotent"
  end
end

describe 'matcher' do
  context 'should be_idempotent' do
    context puppet_apply("whit { 'foo': }") do
      it { subject.stderr.should be_empty }
      it { subject.exit_code.should_not == 1 }
      it { subject.should be_idempotent }
    end

    it 'test as a helper' do
      puppet_apply("whit { 'foo': }") do |r|
        r.stderr.should be_empty
        r.exit_code.should_not == 1
        r.should be_idempotent
      end
    end
  end

  context 'should_not be_idempotent' do
    context puppet_apply("notify { 'foo': }") do
      it { subject.stderr.should be_empty }
      it { subject.exit_code.should_not == 1 }
      it { subject.should_not be_idempotent }
    end

    it 'test as a helper' do
      puppet_apply("notify { 'foo': }") do |r|
        r.stderr.should be_empty
        r.exit_code.should_not == 1
        r.should_not be_idempotent
      end
    end
  end
end
