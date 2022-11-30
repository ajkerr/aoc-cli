require 'spec_helper'

RSpec.describe Year2015::Day04 do
  let(:sample) do 
    <<~EOF
      abcdef
    EOF
  end

  it "solves part1" do
    d = Year2015::Day04.new
    expect(d.part1(sample)).to eq(609043)
  end

  it "solves part2" do
    d = Year2015::Day04.new
    expect(d.part2(sample)).to eq(6742839)
  end
end
