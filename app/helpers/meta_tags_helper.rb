# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags  # rubocop:disable Metrics/MethodLength
    {
      site: 'せるれぽ',
      reverse: true,
      charset: 'utf-8',
      description: '「いつか読みたい本」を安いときに。書籍のセール通知サービス。',
      viewport: 'width=device-width, initial-scale=1.0',
      og: {
        title: :title,
        type: 'website',
        site_name: 'serurepo',
        description: :description,
        image: 'https://serurepo.com/ogp/ogp.png',
        url: 'https://serurepo.com'
      },
      twitter: {
        card: 'summary',
        site: '@fuga__ch',
        description: :description,
        image: 'https://serurepo.com/ogp/ogp.png',
        domain: 'serurepo.com'
      }
    }
  end
end
