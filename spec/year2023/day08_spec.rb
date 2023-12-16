require 'spec_helper'

RSpec.describe Year2023::Day08 do
  let(:sample1) do
    <<~EOF
      RL

      AAA = (BBB, CCC)
      BBB = (DDD, EEE)
      CCC = (ZZZ, GGG)
      DDD = (DDD, DDD)
      EEE = (EEE, EEE)
      GGG = (GGG, GGG)
      ZZZ = (ZZZ, ZZZ)
    EOF
  end

  let(:sample2) do
    <<~EOF
      LLR

      AAA = (BBB, BBB)
      BBB = (AAA, ZZZ)
      ZZZ = (ZZZ, ZZZ)
    EOF
  end

  let(:sample3) do
    <<~EOF
      LR

      11A = (11B, XXX)
      11B = (XXX, 11Z)
      11Z = (11B, XXX)
      22A = (22B, XXX)
      22B = (22C, 22C)
      22C = (22Z, 22Z)
      22Z = (22B, 22B)
      XXX = (XXX, XXX)
    EOF
  end


  it "solves part1" do
    d = Year2023::Day08.new
    expect(d.part1(sample1)).to eq(2)
    expect(d.part1(sample2)).to eq(6)
  end

  it "solves part2" do
    d = Year2023::Day08.new
    expect(d.part2(sample3)).to eq(6)
  end
end
