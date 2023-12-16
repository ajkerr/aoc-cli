require 'spec_helper'

RSpec.describe Year2023::Day15 do
  let(:sample1) do
    <<~EOF
      HASH
    EOF
  end

  let(:sample2) do
    <<~EOF
      rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
    EOF
  end

  it "solves part1" do
    d = Year2023::Day15.new
    expect(d.part1(sample1)).to eq(52)
    expect(d.part1(sample2)).to eq(1320)
  end

  it "solves part2" do
    d = Year2023::Day15.new
    expect(d.part2(sample2)).to eq(145)
  end
end
