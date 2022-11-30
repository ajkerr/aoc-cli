require 'spec_helper'

RSpec.describe Year2015::Day05 do
  let(:sample_1) do
    <<~EOF
      ugknbfddgicrmopn
      aaa
      jchzalrnumimnmhp
      haegwjzuvuyypxyu
      dvszwmarrgswjxmb
    EOF
  end

  let(:sample_2) do
    <<~EOF
      wkvnrwqgjooovhpf
      aaa
      qjhvhtzxzqqjkmpb
      xxyxx
      uurcxstgmygtbstg
      ieodomkazucvgmuy
    EOF
  end

  it "solves part1" do
    d = Year2015::Day05.new
    expect(d.part1(sample_1)).to eq(2)
  end

  it "solves part2" do
    d = Year2015::Day05.new
    expect(d.part2(sample_2)).to eq(2)
  end
end
