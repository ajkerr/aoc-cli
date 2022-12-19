require 'spec_helper'

RSpec.describe Year2022::Day17 do
  let(:sample) do
    <<~EOF
      >>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>
    EOF
  end

  it "solves part1" do
    d = Year2022::Day17.new
    expect(d.part1(sample)).to eq(3068)
  end

  it "solves part2" do
    d = Year2022::Day17.new
    expect(d.part2(sample)).to eq(1514285714288)
  end
end
