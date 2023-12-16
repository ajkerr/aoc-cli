require 'spec_helper'

RSpec.describe Year2023::Day14 do
  let(:sample) do
    <<~EOF
      O....#....
      O.OO#....#
      .....##...
      OO.#O....O
      .O.....O#.
      O.#..O.#.#
      ..O..#O..O
      .......O..
      #....###..
      #OO..#....
    EOF
  end

  it "solves part1" do
    d = Year2023::Day14.new
    expect(d.part1(sample)).to eq(136)
  end

  it "solves part2" do
    d = Year2023::Day14.new
    expect(d.part2(sample)).to eq(64)
  end
end
