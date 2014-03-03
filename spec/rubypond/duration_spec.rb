require 'spec_helper'

describe Duration do
  let(:quarter_note) { Duration.new(1, 4) }
  let(:eigth_note) { Duration.new(1, 8) }
  let(:dotted_half_note) { Duration.new(3, 4) }
  let(:double_dotted_quarter_note) { Duration.new(7, 16) }

  describe '.new' do
    it 'should default the subdivision to 4' do
      expect(Duration.new(1)).to eq quarter_note
    end
  end

  describe '#to_decimal' do
    it 'should treat a whole note as 1' do
      expect(quarter_note.to_decimal).to eq 0.25
      expect(eigth_note.to_decimal).to eq 0.125
      expect(dotted_half_note.to_decimal).to eq 0.75
      expect(double_dotted_quarter_note.to_decimal).to eq 0.4375
    end
  end

  describe '#to_ly' do
    it 'should return the correct lilypond representation of the duration' do
      expect(quarter_note.to_ly).to eq '4'
      expect(eigth_note.to_ly).to eq '8'
      expect(dotted_half_note.to_ly).to eq '2.'
      expect(double_dotted_quarter_note.to_ly).to eq '4..'
      expect(Duration.new(15, 16).to_ly).to eq '2...'
    end
  end
end
