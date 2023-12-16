require 'spec_helper'

RSpec.describe Year2023::Day13 do
  let(:sample) do
    <<~EOF
      #.##..##.
      ..#.##.#.
      ##......#
      ##......#
      ..#.##.#.
      ..##..##.
      #.#.##.#.

      #...##..#
      #....#..#
      ..##..###
      #####.##.
      #####.##.
      ..##..###
      #....#..#
    EOF
  end

  it "solves part1" do
    d = Year2023::Day13.new
    expect(d.part1(sample)).to eq(405)
  end

  it "solves part2" do
    d = Year2023::Day13.new
    expect(d.part2(sample)).to eq(400)
  end
end
