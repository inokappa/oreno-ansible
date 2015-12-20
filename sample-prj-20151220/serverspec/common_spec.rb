require 'spec_helper'

describe file('/tmp/sample.txt') do
  it { should be_file }
end
