require 'spec_helper'

RSpec.describe Year2024::Day10 do
  let(:sample) do
    <<~EOF
      89010123
      78121874
      87430965
      96549874
      45678903
      32019012
      01329801
      10456732
    EOF
  end

  it "solves part1" do
    d = Year2024::Day10.new
    expect(d.part1(sample)).to eq(36)
  end

  it "solves part2" do
    d = Year2024::Day10.new
    expect(d.part2(sample)).to eq(0)
  end
end
