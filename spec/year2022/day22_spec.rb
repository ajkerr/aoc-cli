require 'spec_helper'

RSpec.describe Year2022::Day22 do
  let(:sample) do
    <<~EOF
              ...#
              .#..
              #...
              ....
      ...#.......#
      ........#...
      ..#....#....
      ..........#.
              ...#....
              .....#..
              .#......
              ......#.

      10R5L5R10L4R5L5
    EOF
  end

  it "solves part1" do
    d = Year2022::Day22.new
    expect(d.part1(sample)).to eq(6032)
  end

  it "solves part2" do
    d = Year2022::Day22.new
    expect(d.part2('some_input')).to eq(nil)
  end
end
