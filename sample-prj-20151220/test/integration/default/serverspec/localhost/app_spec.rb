require 'spec_helper'

describe file('/tmp/httpd.conf') do
  it { should be_file }
end
