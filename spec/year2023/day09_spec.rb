require 'spec_helper'

RSpec.describe Year2023::Day09 do
  let(:sample) do
    <<~EOF
      0 3 6 9 12 15
      1 3 6 10 15 21
      10 13 16 21 30 45
    EOF
  end

  it "solves part1" do
    d = Year2023::Day09.new
    expect(d.part1(sample)).to eq(114)
  end

  it "solves part2" do
    d = Year2023::Day09.new
    expect(d.part2(sample)).to eq(2)
  end
end
