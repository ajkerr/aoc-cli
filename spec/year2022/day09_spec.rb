require 'spec_helper'

RSpec.describe Year2022::Day09 do
  let(:sample_1) do
    <<~EOF
      R 4
      U 4
      L 3
      D 1
      R 4
      D 1
      L 5
      R 2
    EOF
  end

  let(:sample_2) do
    <<~EOF
      R 5
      U 8
      L 8
      D 3
      R 17
      D 10
      L 25
      U 20
    EOF
  end

  it "solves part1" do
    d = Year2022::Day09.new
    expect(d.part1(sample_1)).to eq(13)
  end

  it "solves part2" do
    d = Year2022::Day09.new
    expect(d.part2(sample_1)).to eq(1)
    expect(d.part2(sample_2)).to eq(36)
  end
end
