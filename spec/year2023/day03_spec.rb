require 'spec_helper'

RSpec.describe Year2023::Day03 do
  let(:sample) do
    <<~EOF
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
    EOF
  end

  it "solves part1" do
    d = Year2023::Day03.new
    expect(d.part1(sample)).to eq(4361)
  end

  it "solves part2" do
    d = Year2023::Day03.new
    expect(d.part2(sample)).to eq(467835)
  end
end
