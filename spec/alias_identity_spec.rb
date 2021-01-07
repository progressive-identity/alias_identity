RSpec.describe AliasIdentity do
  it "has a version number" do
    expect(AliasIdentity::VERSION).not_to be nil
  end

  before(:each) do
    AliasIdentity.api_key = 'XXX'
  end

  describe 'Owner' do
    it 'creates an owner' do
      expect(AliasIdentity::Owner.create).to eq '42'
    end
  end
end
