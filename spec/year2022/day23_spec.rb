require 'spec_helper'

RSpec.describe Year2022::Day23 do
  let(:small_sample) do
    <<~EOF
      .....
      ..##.
      ..#..
      .....
      ..##.
      .....
    EOF
  end

  let(:sample) do
    <<~EOF
      ....#..
      ..###.#
      #...#.#
      .#...##
      #.###..
      ##.#.##
      .#..#..
    EOF
  end

  it "solves part1" do
    d = Year2022::Day23.new
    # expect(d.part1(small_sample)).to eq(110)
    expect(d.part1(sample)).to eq(110)
  end

  it "solves part2" do
    d = Year2022::Day23.new
    expect(d.part2(sample)).to eq(20)
  end
end
