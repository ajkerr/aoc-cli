require 'spec_helper'

RSpec.describe Year2022::Day21 do
  let(:sample) do
    <<~EOF
      root: pppw + sjmn
      dbpl: 5
      cczh: sllz + lgvd
      zczc: 2
      ptdq: humn - dvpt
      dvpt: 3
      lfqf: 4
      humn: 5
      ljgn: 2
      sjmn: drzm * dbpl
      sllz: 4
      pppw: cczh / lfqf
      lgvd: ljgn * ptdq
      drzm: hmdt - zczc
      hmdt: 32
    EOF
  end

  it "solves part1" do
    d = Year2022::Day21.new
    expect(d.part1(sample)).to eq(152)
  end

  it "solves part2" do
    d = Year2022::Day21.new
    expect(d.part2(sample)).to eq(301)
  end
end
