require 'spec_helper'

RSpec.describe Year2024::Day07 do
  let(:sample) do
    <<~EOF
      190: 10 19
      3267: 81 40 27
      83: 17 5
      156: 15 6
      7290: 6 8 6 15
      161011: 16 10 13
      192: 17 8 14
      21037: 9 7 18 13
      292: 11 6 16 20
    EOF
  end

  it "solves part1" do
    d = Year2024::Day07.new
    expect(d.part1(sample)).to eq(3749)
  end

  it "solves part2" do
    d = Year2024::Day07.new
    expect(d.part2(sample)).to eq(11387)
  end
end
