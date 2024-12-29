require 'spec_helper'

RSpec.describe Year2024::Day06 do
  let(:sample) do
    <<~EOF
      ....#.....
      .........#
      ..........
      ..#.......
      .......#..
      ..........
      .#..^.....
      ........#.
      #.........
      ......#...
    EOF
  end

  it "solves part1" do
    d = Year2024::Day06.new
    expect(d.part1(sample)).to eq(41)
  end

  it "solves part2" do
    d = Year2024::Day06.new
    expect(d.part2(sample)).to eq(6)
  end
end
