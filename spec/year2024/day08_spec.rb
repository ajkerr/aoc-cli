require 'spec_helper'

RSpec.describe Year2024::Day08 do
  let(:sample) do
    <<~EOF
      ............
      ........0...
      .....0......
      .......0....
      ....0.......
      ......A.....
      ............
      ............
      ........A...
      .........A..
      ............
      ............
    EOF
  end

  let(:sample2) do
    <<~EOF
      T.........
      ...T......
      .T........
      ..........
      ..........
      ..........
      ..........
      ..........
      ..........
      ..........
    EOF
  end

  it "solves part1" do
    d = Year2024::Day08.new
    expect(d.part1(sample)).to eq(14)
  end

  it "solves part2" do
    d = Year2024::Day08.new
    expect(d.part2(sample)).to eq(34)
  end
end
