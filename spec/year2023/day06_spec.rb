require 'spec_helper'

RSpec.describe Year2023::Day06 do
  let(:sample) do
    <<~EOF
      Time:      7  15   30
      Distance:  9  40  200
    EOF
  end

  it "solves part1" do
    d = Year2023::Day06.new
    expect(d.part1(sample)).to eq(288)
  end

  it "solves part2" do
    d = Year2023::Day06.new
    expect(d.part2(sample)).to eq(71503)
  end
end
