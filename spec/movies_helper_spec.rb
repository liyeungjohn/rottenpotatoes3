require 'spec_helper'
require 'debugger'
include MoviesHelper
describe MoviesHelper do
  describe 'odd' do
    it 'should return odd' do
      oddness(11).should == "odd"
    end
  end
  describe 'even' do
    it 'should return odd' do
      oddness(10).should == "even"
    end
  end
end

