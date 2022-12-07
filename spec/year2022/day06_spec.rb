require 'spec_helper'

RSpec.describe Year2022::Day06 do
  let(:sample_1) do
    <<~EOF
      mjqjpqmgbljsphdztnvjfqwrcgsmlb
    EOF
  end

  let(:sample_2) do
    <<~EOF
      bvwbjplbgvbhsrlpgdmjqwftvncz
    EOF
  end


  let(:sample_3) do
    <<~EOF
      nppdvjthqldpwncqszvftbrmjlhg
    EOF
  end

  let(:sample_4) do
    <<~EOF
      nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg
    EOF
  end

  let(:sample_5) do
    <<~EOF
      zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw
    EOF
  end

  it "solves part1" do
    d = Year2022::Day06.new
    expect(d.part1(sample_1)).to eq(7)
    expect(d.part1(sample_2)).to eq(5)
    expect(d.part1(sample_3)).to eq(6)
    expect(d.part1(sample_4)).to eq(10)
    expect(d.part1(sample_5)).to eq(11)
  end

  it "solves part2" do
    d = Year2022::Day06.new
    expect(d.part2(sample_1)).to eq(19)
    expect(d.part2(sample_2)).to eq(23)
    expect(d.part2(sample_3)).to eq(23)
    expect(d.part2(sample_4)).to eq(29)
    expect(d.part2(sample_5)).to eq(26)
  end
end
