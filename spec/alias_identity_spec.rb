RSpec.describe AliasIdentity do
  it "has a version number" do
    expect(AliasIdentity::VERSION).not_to be nil
  end

  before(:each) do
    AliasIdentity.api_key = 'XXX'
  end

  describe 'Owner' do
    describe '.create' do
      context 'happy path' do
        it 'creates an owner' do
          expect(AliasIdentity::Owner.create(internal_ref: '1234')).to be_instance_of(AliasIdentity::Owner)
        end
      end

      context 'internal reference already exist' do
        it 'raise an error' do
          expect(AliasIdentity::Owner.create(internal_ref: '1')).to raise_error(AliasIdentity::Owner::AlreadyTakenInternalRef)
        end
      end

      context 'internal reference is nil' do
        it 'raise an error' do
          expect(AliasIdentity::Owner.create(internal_ref: '1')).to raise_error(AliasIdentity::Owner::MissingInternalRef)
        end
      end

      context 'internal reference is an empty string' do
        it 'raise an error' do
          expect(AliasIdentity::Owner.create(internal_ref: '1')).to raise_error(AliasIdentity::Owner::MissingInternalRef)
        end
      end
    end
  end

  describe 'Consent' do
    describe '.give' do
      context 'missing collection' do
        expect(AliasIdentity::Consent.give(
          collection: nil,
          scope: 'voicelab',
          owner_internal_ref: '1234',
          entry_internal_ref: '42'
        )).to raise_error(AliasIdentity::Consent::MissingCollection)

        expect(AliasIdentity::Consent.give(
          collection: '',
          scope: 'voicelab',
          owner_internal_ref: '1234',
          entry_internal_ref: '42'
        )).to raise_error(AliasIdentity::Consent::MissingCollection)
      end

      context 'collection not found' do
        expect(AliasIdentity::Consent.give(
          collection: 'Unknown Collection',
          scope: 'voicelab',
          owner_internal_ref: '1234',
          entry_internal_ref: '42'
        )).to raise_error(AliasIdentity::Consent::CollectionNotFound)
      end

      context 'missing scope' do
        expect(AliasIdentity::Consent.give(
          collection: 'Files',
          scope: nil,
          owner_internal_ref: '1234',
          entry_internal_ref: '42'
        )).to raise_error(AliasIdentity::Consent::MissingScope)

        expect(AliasIdentity::Consent.give(
          collection: 'Files',
          scope: '',
          owner_internal_ref: '1234',
          entry_internal_ref: '42'
        )).to raise_error(AliasIdentity::Consent::MissingScope)
      end

      context 'owner not found' do
        expect(AliasIdentity::Consent.give(
          collection: 'Unknown Collection',
          scope: 'voicelab',
          owner_internal_ref: '1234x',
          entry_internal_ref: '42'
        )).to raise_error(AliasIdentity::Consent::OwnerNotFound)
      end


      context 'missing owner' do
        expect(AliasIdentity::Consent.give(
          collection: 'Files',
          scope: 'voicelab',
          owner_internal_ref: nil,
          entry_internal_ref: '42'
        )).to raise_error(AliasIdentity::Consent::MissingOwner)

        expect(AliasIdentity::Consent.give(
          collection: 'Files',
          scope: 'voicelab',
          owner_internal_ref: '',
          entry_internal_ref: '42'
        )).to raise_error(AliasIdentity::Consent::MissingOwner)
      end

      context 'missing entry' do
        expect(AliasIdentity::Consent.give(
          collection: 'Files',
          scope: 'voicelab',
          owner_internal_ref: 1234,
          entry_internal_ref: nil
        )).to raise_error(AliasIdentity::Consent::MissingEntry)

        expect(AliasIdentity::Consent.give(
          collection: 'Files',
          scope: 'voicelab',
          owner_internal_ref: '1234',
          entry_internal_ref: ''
        )).to raise_error(AliasIdentity::Consent::MissingEntry)
      end

      context 'entry not found' do
        expect(AliasIdentity::Consent.give(
          collection: 'Unknown Collection',
          scope: 'voicelab',
          owner_internal_ref: '1234',
          entry_internal_ref: '42'
        )).to raise_error(AliasIdentity::Consent::OwnerNotFound)
      end
    end

    describe '.retrieve' do
      
    end
  end
end
