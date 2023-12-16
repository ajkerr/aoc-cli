require 'spec_helper'

RSpec.describe Year2023::Day12 do
  let(:sample) do
    <<~EOF
      ???.### 1,1,3
      .??..??...?##. 1,1,3
      ?#?#?#?#?#?#?#? 1,3,1,6
      ????.#...#... 4,1,1
      ????.######..#####. 1,6,5
      ?###???????? 3,2,1
    EOF
  end

  it "solves part1" do
    d = Year2023::Day12.new
    expect(d.part1(sample)).to eq(21)
  end

  it "solves part2" do
    d = Year2023::Day12.new
    expect(d.part2('some_input')).to eq(nil)
  end
end
