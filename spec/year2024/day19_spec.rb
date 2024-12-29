require 'spec_helper'

RSpec.describe Year2024::Day19 do
  let(:sample) do
    <<~EOF
      r, wr, b, g, bwu, rb, gb, br

      brwrr
      bggr
      gbbr
      rrbgbr
      ubwu
      bwurrg
      brgr
      bbrgwb
    EOF
  end

  it "solves part1" do
    d = Year2024::Day19.new
    expect(d.part1(sample)).to eq(6)
  end

  it "solves part2" do
    d = Year2024::Day19.new
    expect(d.part2('some_input')).to eq(nil)
  end
end
