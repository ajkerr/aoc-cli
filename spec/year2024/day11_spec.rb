require 'spec_helper'

RSpec.describe Year2024::Day11 do
  let(:sample) do
    <<~EOF
      125 17
    EOF
  end

  it "solves part1" do
    d = Year2024::Day11.new
    expect(d.part1(sample)).to eq(55312)
  end

  it "solves part2" do
    d = Year2024::Day11.new
    expect(d.part2(sample)).to eq(65601038650482)
  end
end
