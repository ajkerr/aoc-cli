require 'spec_helper'

RSpec.describe Year2023::Day17 do
  let(:sample) do
    <<~'EOF'
      2413432311323
      3215453535623
      3255245654254
      3446585845452
      4546657867536
      1438598798454
      4457876987766
      3637877979653
      4654967986887
      4564679986453
      1224686865563
      2546548887735
      4322674655533
    EOF
  end

  it "solves part1" do
    d = Year2023::Day17.new
    expect(d.part1(sample)).to eq(102)
  end

  it "solves part2" do
    d = Year2023::Day17.new
    expect(d.part2('some_input')).to eq(nil)
  end
end
