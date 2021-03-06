require 'airport'

describe Airport do
  subject { described_class.new(20, weather) }
  let(:plane) { double(:plane) }
  let(:weather) { double(:weather) }

    describe'#land' do
      context 'when not stormy' do
        before do
          allow(weather).to receive(:stormy?).and_return false
        end

        it 'instructs a plane to land' do
          expect(subject).to respond_to(:land).with(1).argument
        end

        context 'when airport is full' do
          it 'raises an error' do
            20.times { subject.land(plane) }
            expect { subject.land(plane) }.to raise_error "Cannot land plane as airport is full"
          end
        end
      end

    context 'when stormy'  do
      it 'raises an error when stormy' do
        allow(weather).to receive(:stormy?).and_return true
        expect { subject.land(plane) }.to raise_error "Cannot land plane as it is stormy"
      end
    end
  end

  describe '#take_off' do
    context 'when not stormy' do
      it 'instructs a plane to take off' do
        expect(subject).to respond_to(:take_off).with(1).argument
      end
    end

    context 'when stormy' do
      before do
        allow(weather).to receive(:stormy?).and_return true
      end
      it 'raises an error' do
        expect { subject.take_off(plane) }.to raise_error "Cannot take off as it is stormy"
      end
    end
  end

end
