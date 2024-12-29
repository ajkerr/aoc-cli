require 'spec_helper'

RSpec.describe Year2024::Day09 do
  let(:sample) do
    <<~EOF
      2333133121414131402
    EOF
  end

  it "solves part1" do
    d = Year2024::Day09.new
    expect(d.part1(sample)).to eq(1928)
  end

  it "solves part2" do
    d = Year2024::Day09.new
    expect(d.part2(sample)).to eq(2858)
  end
end
