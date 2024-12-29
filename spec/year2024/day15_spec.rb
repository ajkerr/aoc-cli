require 'spec_helper'

RSpec.describe Year2024::Day15 do
  let(:sample) do
    <<~EOF
      p=0,4 v=3,-3
      p=6,3 v=-1,-3
      p=10,3 v=-1,2
      p=2,0 v=2,-1
      p=0,0 v=1,3
      p=3,0 v=-2,-2
      p=7,6 v=-1,-3
      p=3,0 v=-1,-2
      p=9,3 v=2,3
      p=7,3 v=-1,2
      p=2,4 v=2,-3
      p=9,5 v=-3,-3
    EOF
  end

  it "solves part1" do
    d = Year2024::Day15.new
    expect(d.part1(sample)).to eq()
  end

  it "solves part2" do
    d = Year2024::Day15.new
    expect(d.part2('some_input')).to eq(nil)
  end
end
