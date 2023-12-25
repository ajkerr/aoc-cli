require 'spec_helper'

RSpec.describe Year2023::Day18 do
  let(:sample) do
    <<~'EOF'
      R 6 (#70c710)
      D 5 (#0dc571)
      L 2 (#5713f0)
      D 2 (#d2c081)
      R 2 (#59c680)
      D 2 (#411b91)
      L 5 (#8ceee2)
      U 2 (#caa173)
      L 1 (#1b58a2)
      U 2 (#caa171)
      R 2 (#7807d2)
      U 3 (#a77fa3)
      L 2 (#015232)
      U 2 (#7a21e3)
    EOF
  end

  it "solves part1" do
    d = Year2023::Day18.new
    expect(d.part1(sample)).to eq(62)
  end

  it "solves part2" do
    d = Year2023::Day18.new
    expect(d.part2(sample)).to eq(952408144115)
  end
end
