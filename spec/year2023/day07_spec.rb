require 'spec_helper'

RSpec.describe Year2023::Day07 do
  let(:sample) do
    <<~EOF
      32T3K 765
      T55J5 684
      KK677 28
      KTJJT 220
      QQQJA 483
    EOF
  end

  it "solves part1" do
    d = Year2023::Day07.new
    expect(d.part1(sample)).to eq(6440)
  end

  it "solves part2" do
    d = Year2023::Day07.new
    expect(d.part2(sample)).to eq(5905)
  end
end
