require 'spec_helper'

RSpec.describe Year2023::Day01 do
  let(:sample) do
    <<~EOF
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
    EOF
  end

  let(:sample2) do
    <<~EOF
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
    EOF
  end

  it "solves part1" do
    d = Year2023::Day01.new
    expect(d.part1(sample)).to eq(142)
  end

  it "solves part2" do
    d = Year2023::Day01.new
    expect(d.part2(sample2)).to eq(281)
  end
end
