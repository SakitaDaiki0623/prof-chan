module ApplicationHelper

  def page_title(page_title = '')
    base_title = 'プロフちゃん'
    page_title.empty? ? base_title : page_title + ' - ' + base_title
  end

  def default_meta_tags
    {
      title:       "社内プロフィール共有サービス 【プロフちゃん】",
      description: "フルリモート体制の会社員に贈る、雑談のきっかけとなる話題を社内共有するサービスです。",
      keywords:    "remote_work,covid,profile_note,prof_chan", #キーワードを「,」で区切る
      icon: [
        { href: image_url('prof_normal.png') },
      ],
      noindex: ! Rails.env.production?,
      canonical: request.original_url,
      charset: "UTF-8",
      og: {
        title: "社内プロフィール共有サービス 【プロフちゃん】",                #上のtitleと同じ値とするなら「:title」とする
        description: "フルリモート体制の会社員に贈る、雑談のきっかけとなる話題を社内共有するサービスです。", #上のdescriptionと同じ値とするなら「:description」とする
        type: "website",
        url: request.original_url,
        image: image_url("ogp_image.png"),
        site_name: "Profchan",
        locale: "ja_JP"
      },
      twitter: {
        site: '@profchanjp',
        card: 'summary_large_image',
        image: image_url("twitter_ogp_image.png") # ツイッター専用にイメージを設定する場合
      },
      fb: {
        app_id: '***************'
      }
    }
  end
end
