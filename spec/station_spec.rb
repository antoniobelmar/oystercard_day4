require 'station'

describe Station do
  let(:station) { Station.new('Bank', 1) }

  # describe '#initialize' do
  #   it 'returns a new instance of Station with a zone' do
  #     expect(Station).to respond_to(:new).with(kind_of(Fixnum))
  #   end
  # end

  describe '#name' do
    it { expect(station.name).to eq('Bank') }
  end

  describe '#zone' do
    it { expect(station.zone).to eq(1) }
  end

  describe 'initialize' do
    context 'when passing in a Zone number not between 1 and 6' do
      [7, 0, -1].each do |zone|
        it "returns a fail error for #{zone} " do
          expect { Station.new('Bank', zone) }.to raise_error('Please enter zone number between 1 and 6')
        end
      end
    end
  end
end
