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
        title: 'せるれぽ',
        type: 'website',
        site_name: 'serurepo',
        description: '「いつか読みたい本」を安いときに。書籍のセール通知サービス。',
        image: 'https://serurepo.com/ogp/ogp.png',
        url: 'https://serurepo.com'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@fuga__ch',
        description: '「いつか読みたい本」を安いときに。書籍のセール通知サービス。',
        image: 'https://serurepo.com/ogp/ogp.png',
        domain: 'https://serurepo.com'
      }
    }
  end
end
