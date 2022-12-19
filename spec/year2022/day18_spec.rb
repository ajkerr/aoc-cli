require 'spec_helper'

RSpec.describe Year2022::Day18 do
  let(:sample) do
    <<~EOF
      2,2,2
      1,2,2
      3,2,2
      2,1,2
      2,3,2
      2,2,1
      2,2,3
      2,2,4
      2,2,6
      1,2,5
      3,2,5
      2,1,5
      2,3,5
    EOF
  end

  it "solves part1" do
    d = Year2022::Day18.new
    expect(d.part1(sample)).to eq(64)
  end

  it "solves part2" do
    d = Year2022::Day18.new
    expect(d.part2(sample)).to eq(58)
  end
end
