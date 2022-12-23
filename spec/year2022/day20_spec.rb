require 'spec_helper'

RSpec.describe Year2022::Day20 do
  let(:sample) do
    <<~EOF
      1
      2
      -3
      3
      -2
      0
      4
    EOF
  end

  it "solves part1" do
    d = Year2022::Day20.new
    expect(d.part1(sample)).to eq(3)
  end

  it "solves part2" do
    d = Year2022::Day20.new
    expect(d.part2(sample)).to eq(1623178306)
  end
end
