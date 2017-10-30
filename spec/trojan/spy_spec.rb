require "spec_helper"

class FakeClass
  def test_a; "hello" end
  def test_b(a, b); a + b end
end

RSpec.describe Trojan::Spy do
  let(:obj) { FakeClass.new }
  subject(:spy) { Trojan::Spy.new(obj, :test_a) }

  describe ".new" do
    it "instantiates a Trojan::Spy" do
      expect(spy).to be_instance_of(Trojan::Spy)
    end
  end

  describe "#hook!" do
    it "overwrites the original method" do
      spy.hook!
      expect(obj.test_a).to_not eql("hello")
    end

    it "raises an error if called when hooked" do
      spy.hook!
      expect { spy.hook! }.to raise_error(RuntimeError, /already been hooked/)
    end
  end

  describe "#unhook!" do
    it "restores the original method" do
      spy.hook!
      spy.unhook!
      expect(obj.test_a).to eql("hello")
    end

    it "raises an error if called when not hooked" do
      expect { spy.unhook! }.to raise_error(RuntimeError, /has not been hooked/)
    end
  end

  describe '#calls' do
    before { spy.hook! }

    it "returns array with one entry per call" do
      3.times { obj.test_a(rand, a: rand) }
      expect(spy.calls.count).to eql(3)
    end
  end
end
