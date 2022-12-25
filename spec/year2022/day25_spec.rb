require 'spec_helper'

RSpec.describe Year2022::Day25 do
  let(:sample) do
    <<~EOF
      1=-0-2
      12111
      2=0=
      21
      2=01
      111
      20012
      112
      1=-1=
      1-12
      12
      1=
      122
    EOF
  end

  it "solves part1" do
    d = Year2022::Day25.new
    expect(d.part1(sample)).to eq("2=-1=0")
  end

  it "solves part2" do
    d = Year2022::Day25.new
    expect(d.part2('some_input')).to eq(nil)
  end
end
