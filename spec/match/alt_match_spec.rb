describe I18n::HTMLExtractor::Match::AltMatch do
  let(:document) do
    I18n::HTMLExtractor::ErbDocument.parse_string(text)
  end
  let(:node) { document.xpath('./div/*').first }
  subject { described_class.create(document, node) }

  context 'when matching inputs' do
    let(:text) { '<div><img alt="Octocat Avatar" src="https://avatars.githubusercontent.com/u/583231?v=4"></img></div>' }

    it 'extracts the alt value' do
      expect(subject).to be_a(Array)
      subject.compact!
      result = subject.first
      expect(result.text).to eq('Octocat Avatar')
      result.replace_text!
      expect(node['alt']).to match(/^@@=.*@@$/)
      expect(document.erb_directives.keys.count).to eq(1)
    end
  end
end
