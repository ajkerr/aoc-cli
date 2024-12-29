require 'spec_helper'

RSpec.describe Year2024::Day17 do
  let(:sample) do
    <<~EOF
      Register A: 729
      Register B: 0
      Register C: 0

      Program: 0,1,5,4,3,0
    EOF
  end

  let(:sample_2) do
    <<~EOF
      Register A: 10
      Register B: 0
      Register C: 0

      Program: 5,0,5,1,5,4
    EOF
  end

  let(:sample_3) do
    <<~EOF
      Register A: 2024
      Register B: 0
      Register C: 0

      Program: 0,3,5,4,3,0
    EOF
  end

  it "solves part1" do
    d = Year2024::Day17.new
    expect(d.part1(sample)).to eq('4,6,3,5,6,3,5,2,1,0')
    expect(d.part1(sample_2)).to eq('0,1,2')
  end

  it "solves part2" do
    d = Year2024::Day17.new
    expect(d.part2(sample_3)).to eq(117440)
  end
end
